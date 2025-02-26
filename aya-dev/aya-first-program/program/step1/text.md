Generate a new Aya project on /host/root/ directory
* Project name: `aya-test`
* Type of eBPF program: tracepoint
* tracepoint **category**: `syscalls`
* tracepoint **name**: `sys_enter_execve`

<br>

In the container run these commands:

```plain
cd /host/root/ # You change directory to the host volume
cargo generate https://github.com/aya-rs/aya-template #Answer the questions
```{{exec}}

Tracepoints are, as the name suggests, places in the Linux code that have been marked (see [recommendations](https://docs.kernel.org/trace/tracepoints.html)). They are mainly used for tracing and debugging the Linux kernel.

![code to add in Linux kernel for Tracepoint](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ouqwk4w9lvgs2jsv5hgk.png)

All these points are accessible in the `/sys/kernel/debug/tracing/available_events` file:

![A slice of this file](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/tydi0rmsij9m6bwssvct.png)
