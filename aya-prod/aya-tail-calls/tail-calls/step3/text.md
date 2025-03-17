You need to clean 

```rust
fn try_tracepoint_binary_display(ctx: TracePointContext) -> Result<u32, i64> {
    debug!(&ctx, "display");
    let buf = BUF.get(0).ok_or(0)?;
    let cmd = &buf[..];
    let filename = unsafe { from_utf8_unchecked(cmd) };
    info!(&ctx, "tracepoint sys_enter_execve called. Binary: {}", filename);
    Ok(0)
}
```{{copy}}

Don't forget to add library:

```rust
use aya_log_ebpf::debug;
```{{copy}}

```plain
cd /host/root/project
RUST_LOG=debug cargo run
```{{exec interrupt}}
