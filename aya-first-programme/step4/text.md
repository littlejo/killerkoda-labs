Now you have to improve the code to log which command is executed.

You have to modified kernel space programme: test-aya-ebpf/src/main.rs

Particularly this code:
```plain
fn try_aya_test(ctx: TracePointContext) -> Result<u32, u32> {
    info!(&ctx, "tracepoint syscalls called");
    Ok(0)
}
```
You can have information about TracePointContext on: https://docs.rs/aya-ebpf/latest/aya_ebpf/programs/tracepoint/struct.TracePointContext.html

<br>

Run the following command to information about syscall execve:
```plain
cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_execve/format
```{{exec}}

The filename is at the offset 16. So you have to add in try_aya_test function:

```plain
let _filename_src_addr = unsafe {ctx.read_at::<*const u8>(16)?};
```

Try to launch cargo run but you will have typing error. You have to change return function:

```plain
fn try_test_aya(ctx: TracePointContext) -> Result<u32, i64> { //u32 -> i64
```

And modify test_aya function using cast:
```plain
pub fn test_aya(ctx: TracePointContext) -> u32 {
    match try_test_aya(ctx) {
        Ok(ret) => ret,
        Err(ret) => ret as u32, //cast
    }
}
```

* Now it should be compiled.
