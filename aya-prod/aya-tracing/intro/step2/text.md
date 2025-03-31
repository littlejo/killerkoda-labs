Test the eBPF program before making any modifications... In the container, run these commands:

```plain
cd /host/root/project
RUST_LOG=info cargo run
```{{exec}}

![screenshot of command](../../img/screenshot-command.png)

* It can take a long time. In addition to [the article](https://dev.to/littlejo/enhancing-your-aya-program-with-ebpf-maps-4hdj), you also can read [documentation about eBPF tail calls](https://docs.ebpf.io/linux/concepts/tail-calls/):

![screenshot of documentation](../../img/doc-ebpf-tail-calls.png)

* When you see: "Waiting for Ctrl-C...", You must see on the terminal, something like:
```plain
[INFO  tracepoint_binary] No log for this Binary
```
