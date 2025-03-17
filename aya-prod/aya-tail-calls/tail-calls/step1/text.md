Now you need to modify user side of your code. So you are in the this directory: `tracepoint-binary-ebpf/src/`

The goal of `hook.rs` is to retrieve the binaries that are being executed. So, you need to clean up `hook.rs`.

### Update the `try_tracepoint_binary` function

You should have the following code in your `hook.rs` file for the main function:

```rust
fn try_tracepoint_binary(ctx: TracePointContext) -> Result<u32, i64> {
    debug!(&ctx, "hook");
    let buf = BUF.get_ptr_mut(0).ok_or(0)?;

    unsafe {
        *buf = ZEROED_ARRAY;
        let filename_src_addr = ctx.read_at::<*const u8>(FILENAME_OFFSET)?;
        bpf_probe_read_user_str_bytes(filename_src_addr, &mut *buf)?;
    }

    Ok(0)
}
```{{copy}}

### Add a jump to the filter program 

Next, you need to add a tail call to the filter program:

```rust
let res = unsafe { JUMP_TABLE.tail_call(&ctx, 0)};
if res.is_err() {
     error!(&ctx, "hook: tail_call failed");
}
```{{copy}}

Also, **import the required library**:

```rust
use aya_log_ebpf::{debug,error};
```{{copy}}

### Clean up unused imports 

As part of cleanup, don't forget to remove any unnecessary imports from the top of the file.

### Compile and run the code

Ensure your code compiles successfully:

```plain
cd /host/root/project
RUST_LOG=debug cargo run
```{{exec interrupt}}

Now, your `hook.rs` is clean and only contains the essential logic to interact with the filter program.
