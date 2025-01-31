Generate a new Aya project on /host/root/ directory
* Project name: aya-test
* Type of eBPF program: tracepoint
* tracepoint category: `syscalls`
* tracepoint name: `sys_enter_execve`

<br>

### Solution

```plain
cd /host/root/
cargo generate https://github.com/aya-rs/aya-template #Answer the questions
```{{exec}}
