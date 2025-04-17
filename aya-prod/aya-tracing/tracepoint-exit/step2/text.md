Now we only work on kernel space until the end of the lab: `tracepoint-binary-ebpf/src` directory.

What can we retrieve with this tracepoint?

Run these commands:

```plain
cat /sys/kernel/debug/tracing/events/syscalls/sys_exit_execve/format
```{{exec interrupt}}
```plain
name: sys_exit_execve
ID: 785
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:int __syscall_nr; offset:8;       size:4; signed:1;
        field:long ret; offset:16;      size:8; signed:1;

print fmt: "0x%lx", REC->ret
```

The only one field interesting is ret. It's at offset 16. It's return code of the syscall execve.

So you need to replace this line in the `hook_exit.rs` file:

```rust
    info!(&ctx, "tracepoint sys_exit_execve called.");
```

by:

```rust
let ret :i64 = unsafe { ctx.read_at(16)? };
info!(&ctx, "tracepoint sys_exit_execve called. ret: {}", ret);
```{{copy}}

Now you can test:
```
cargo run
```{{exec}}

## In another terminal

* Launch a command which the binary doesn't exist:
```
./command_not_found
```{{exec interrupt}}

What is the return code?

* Launch a command not executable:
```
touch ./command_not_exec && ./command_not_exec
```{{exec}}
What is the return code?

* Launch a command with no library:
```
wget -qO- https://github.com/littlejo/check-cilium-clustermesh/releases/download/v0.0.8/cilium-clustermesh-terratest-0.0.8-darwin-arm64.tar.gz | tar xz && ./check-cilium-clustermesh
```{{exec}}
What is the return code?
