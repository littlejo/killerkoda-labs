What can we retrieve with this tracepoint?

Run these commands:

```plain
cat /sys/kernel/debug/tracing/events/syscalls/sys_exit_execve/format
```{{exec interrupt}}

The only one field interesting is ret. It's at offset 16. It's return code of the syscall execve.

So you need to replace this line in the `hook_exit.rs` file:

```Rust
    info!(&ctx, "tracepoint sys_exit_execve called.");
```

by:

```Rust
let ret :i64 = unsafe { ctx.read_at(16)? };
info!(&ctx, "tracepoint sys_exit_execve called. ret: {}", ret);
```{{copy}}

Now you can test:
```
cargo run
```{{exec}}
