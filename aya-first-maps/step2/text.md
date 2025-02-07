Test the eBPF program:

<br>

In the container, run these commands:

```plain
cd /host/root/aya-examples/tracepoint-binary
RUST_LOG=info cargo run
```{{exec}}

* When you see: "Waiting for Ctrl-C...", You must see on the terminal:
```plain
[INFO  aya_test] tracepoint sys_enter_execve called Binary: $NAME_OF_BINARY
```
