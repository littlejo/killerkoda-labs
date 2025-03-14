Test the eBPF program before making any modifications... In the container, run these commands:

```plain
cd /host/root/project
RUST_LOG=info cargo run
```{{exec}}

![screenshot of command](../../img/screenshot-command.png)

* It can take a long time. In addition to [the article](https://dev.to/littlejo/enhancing-your-aya-program-with-ebpf-maps-4hdj), you also can read [documentation about eBPF maps](https://docs.ebpf.io/linux/concepts/maps/):

![screenshot of documentation](../../img/doc-ebpf-maps.png)

* When you see: "Waiting for Ctrl-C...", You must see on the terminal:
```plain
[INFO  aya_test] tracepoint sys_enter_execve called Binary: $NAME_OF_BINARY
```

* You can click on this icon to split terminal:

![screenshot of split terminal](../../img/screenshot-split.png)

* On another terminal, launch:

```plain
/usr/sbin/update-rc.d
/usr/sbin/usb_modeswitch_dispatcher
```{{exec}}

* On the editor tab, you must see a bug.

![screenshot of the terminals](../../img/screenshot-bug.png)
