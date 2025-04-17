![Diagram: How to retrieve BUF map?](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/fx8chsm2be9tshssj4pt.png)

Now that we've managed to retrieve the duration of the execve syscall, it would be nice to have everything on the same line: binary name, duration and return code. The output tracepoint program must therefore be able to retrieve the buffer filled by the input tracepoint program.

The hook exit program can't retrieve directly BUF map because the type of map is not design for that. So you need to convert into LruHashMap, the same type as `T_ENTER` map.

## Common

In `common.rs`, So you need to replace:
```rust
#[map]
pub static BUF: PerCpuArray<[u8; MAX_PATH_LEN]> = PerCpuArray::with_max_entries(1, 0);
```

by:

```rust
#[map]
pub static BUF: LruHashMap<u32, [u8; MAX_PATH_LEN]> = LruHashMap::with_max_entries(16, 0);
```{{copy}}


## Hook

In `hook.rs`, you need to change like that:

```rust
fn try_tracepoint_binary(ctx: TracePointContext) -> Result<u32, i64> {
    let t = unsafe{ bpf_ktime_get_ns() };
    debug!(&ctx, "main {}", t);
    let tgid = (bpf_get_current_pid_tgid() >> 32) as u32;
    T_ENTER.insert(&tgid, &t, 0)?;
    BUF.insert(&tgid, &ZEROED_ARRAY, 0)?; //CHANGED
    let buf = BUF.get_ptr_mut(&tgid).ok_or(0)?; //CHANGED
    unsafe {
        let filename_src_addr = ctx.read_at::<*const u8>(FILENAME_OFFSET)?;
        bpf_probe_read_user_str_bytes(filename_src_addr, &mut *buf)?;
    };

    try_tail_call(&ctx, 0);

    Ok(0)
}
```{{copy}}

## Filter

In `filter.rs`, you need to change like that:
```rust
fn try_tracepoint_binary_filter(ctx: TracePointContext) -> Result<u32, i64> {
    debug!(&ctx, "filter");
    let tgid = (bpf_get_current_pid_tgid() >> 32) as u32; //ADDED
    let buf = unsafe { BUF.get(&tgid).ok_or(0)? }; //CHANGED

    let is_excluded = unsafe { EXCLUDED_CMDS.get(buf).is_some() };

    if is_excluded {
        debug!(&ctx, "No log for this Binary");
        return Ok(0);
    }

    try_tail_call(&ctx, 1);

    Ok(0)
}
```{{copy}}

Don't forget to add library:
```rust
use aya_ebpf::helpers::bpf_get_current_pid_tgid;
```{{copy}}

## Display

In `display.rs`, you need to change like that:

```rust
fn try_tracepoint_binary_display(ctx: TracePointContext) -> Result<u32, i64> {
    debug!(&ctx, "display");
    let tgid = (bpf_get_current_pid_tgid() >> 32) as u32; //ADD
    let buf = unsafe { BUF.get(&tgid).ok_or(0)? }; //CHANGED
    let cmd = &buf[..];
    let filename = unsafe { from_utf8_unchecked(cmd) };

    info!(
        &ctx,
        "tracepoint sys_enter_execve called. Binary: {}", filename
    );
    Ok(0)
}
```{{copy}}

Don't forget to add library:
```rust
use aya_ebpf::helpers::bpf_get_current_pid_tgid;
```{{copy}}

Now you can test the program:
```
RUST_LOG=info cargo run
```{{exec interrupt}}
