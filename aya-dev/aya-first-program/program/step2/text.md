Test the eBPF program. In the container, run these commands:

```plain
cd /host/root/aya-test
RUST_LOG=info cargo run
```{{exec}}

![Schema to show what cargo run do](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/g6bp1c1090w5wjppabkd.png)

* When you see: "Waiting for Ctrl-C...", You must see on the terminal:
```plain
[INFO  aya_test] tracepoint sys_enter_execve called
```
* Which binaries are being launched? eBPF can help you find them.

![hook schema](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/pvxfo2t6mtvzdymrte1i.png)
