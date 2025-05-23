![work flow of map: input](../../img/map-workflow-5.png)

Now you have to create a check in the **kernel environment** if the binary is in the list

For that, we have to modify this file: `tracepoint-binary-ebpf/src/main.rs`

* Add these lines:
```rust
if EXCLUDED_CMDS.get(& *buf).is_some() {
           info!(&ctx, "No log for this Binary");
           return Ok(0);
}
```{{copy}}

before this line: `from_utf8_unchecked(filename_bytes)`

* Now it should be compiled:
```bash
cd /host/root/project
RUST_LOG=info cargo run
```{{exec interrupt}}

* It can work:
```
[INFO  tracepoint_binary] No log for this Binary
[INFO  tracepoint_binary] No log for this Binary
[INFO  tracepoint_binary] No log for this Binary
[INFO  tracepoint_binary] No log for this Binary
```

* Try to open another terminal


Now you should see:
```
[INFO  tracepoint_binary] tracepoint sys_enter_execve called. Binary: /usr/bin/sleep
[INFO  tracepoint_binary] tracepoint sys_enter_execve called. Binary: /usr/bin/ls
```
* Did you find the bug?
