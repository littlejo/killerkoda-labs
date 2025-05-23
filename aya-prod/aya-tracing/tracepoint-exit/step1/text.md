We're going to create a hello world Tracepoint program for "syscalls:sys_exit_execve".

Let's create another program in the kernel side:

```
cp tracepoint-binary-ebpf/src/hook.rs tracepoint-binary-ebpf/src/hook_exit.rs
sed -i 's/tracepoint_binary/tracepoint_binary_exit/' tracepoint-binary-ebpf/src/hook_exit.rs
```{{exec interrupt}}


Just empty the file to only have:

```rust
use aya_ebpf::{
    macros::tracepoint, programs::TracePointContext,
};

use aya_log_ebpf::info;

#[tracepoint]
pub fn tracepoint_binary_exit(ctx: TracePointContext) -> u32 {
    match try_tracepoint_binary_exit(ctx) {
        Ok(ret) => ret,
        Err(ret) => ret as u32,
    }
}

fn try_tracepoint_binary_exit(ctx: TracePointContext) -> Result<u32, i64> {
    info!(&ctx, "tracepoint sys_exit_execve called.");
    Ok(0)
}
```{{copy}}

You also add on `main.rs`:
```rust
mod hook_exit;
```{{copy}}

On the user side, you need to load this program in the `tracepoint-binary/src/main.rs` file.

So you need to add:

```rust
let program: &mut TracePoint = ebpf.program_mut("tracepoint_binary_exit").unwrap().try_into()?;
program.load()?;
program.attach("syscalls", "sys_exit_execve")?;
```{{copy}}

After these lines:

```rust
let program: &mut TracePoint = ebpf.program_mut("tracepoint_binary").unwrap().try_into()?;
program.load()?;
program.attach("syscalls", "sys_enter_execve")?;
```

Now you can test:
```
cargo run
```{{exec}}

If you open a new terminal you can obtain something like:

![Output of exit hello world program](../../img/output-hello-world.png)
