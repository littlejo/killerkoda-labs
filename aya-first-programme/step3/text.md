Test the eBPF programme:

<br>

### Solution

```plain
cd /host/root/aya-test
RUST_LOG=info cargo run
```{{exec}}

* When you see: "Waiting for Ctrl-C..."
* On another terminal, launch shell command.

You must see on the "cargo run" terminal:
[INFO  aya_test] tracepoint sys_enter_execve called
