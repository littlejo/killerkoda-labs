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

