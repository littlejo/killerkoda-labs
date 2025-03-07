Test the eBPF program:

<br>

In the container, run these commands:

```plain
cd /host/root/tracepoint-binary
RUST_LOG=info cargo run
```{{exec}}

* It can take a long time. In addition to the article, you also can read [documentation about eBPF maps](https://docs.ebpf.io/linux/concepts/maps/):

![screenshot of the article](../../img/doc-ebpf-maps.png)

* When you see: "Waiting for Ctrl-C...", You must see on the terminal:
```plain
[INFO  aya_test] tracepoint sys_enter_execve called Binary: $NAME_OF_BINARY
```

* On another terminal, launch:

```plain
/usr/sbin/update-rc.d
/usr/sbin/usb_modeswitch_dispatcher
```{{exec}}

* On the editor tab, you must see a bug.

![screenshot of the terminals](../../img/screenshot-bug.png)
