You need to clean hook.rs.

```rust
fn try_tracepoint_binary(ctx: TracePointContext) -> Result<u32, i64> {
    debug!(&ctx, "hook");
    let buf = BUF.get_ptr_mut(0).ok_or(0)?;

    unsafe {
        *buf = ZEROED_ARRAY;
        let filename_src_addr = ctx.read_at::<*const u8>(FILENAME_OFFSET)?;
        bpf_probe_read_user_str_bytes(filename_src_addr, &mut *buf)?;
    }

    Ok(0)
}
```{{copy}}

Don't forget to add library:

```rust
use aya_log_ebpf::debug;
```{{copy}}

You need to add jump to the filter program:

```rust
let res = unsafe { JUMP_TABLE.tail_call(&ctx, 0)};
if res.is_err() {
     error!(&ctx, "hook: tail_call failed");
}
```{{copy}}

```plain
cd /host/root/project
RUST_LOG=debug cargo run
```{{exec interrupt}}
