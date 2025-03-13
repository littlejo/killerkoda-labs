You need to clean filter.rs.

```rust
fn try_tracepoint_binary_filter(ctx: TracePointContext) -> Result<u32, i64> {
    debug!(&ctx, "filter");
    let buf = BUF.get(0).ok_or(0)?;

    let is_excluded = unsafe {
        EXCLUDED_CMDS.get(buf).is_some()
    };

    if is_excluded {
        debug!(&ctx, "No log for this Binary");
        return Ok(0);
    }

    Ok(0)
}
```{{copy}}

Don't forget to add library:

```rust
use aya_log_ebpf::debug;
```{{copy}}

You need to add jump to the display program:

```rust
let res = unsafe { JUMP_TABLE.tail_call(&ctx, 1) };
if res.is_err() {
    error!(&ctx, "filter: tail_call failed");
}
```{{copy}}

```plain
cd /host/root/project
RUST_LOG=debug cargo run
```{{exec interrupt}}
