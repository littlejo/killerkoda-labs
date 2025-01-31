Test the eBPF program:

<br>

### Solution

```plain
cd /host/root/aya-test
RUST_LOG=info cargo run
```{{exec}}

* When you see: "Waiting for Ctrl-C...", You must see on the terminal:
```plain
[INFO  aya_test] tracepoint sys_enter_execve called
```
* Which binaries are launched ?
