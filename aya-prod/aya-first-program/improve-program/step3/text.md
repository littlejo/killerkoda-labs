You just retrieved the address of your filename in the memory.

Now you have to read the address to have the filename in (bytes format).

You have to modified kernel space program: `aya-test-ebpf/src/main.rs`

Particularly this code:
```rust
fn try_test_aya(ctx: TracePointContext) -> Result<u32, i64> {
    let _filename_src_addr = unsafe {ctx.read_at::<*const u8>(16)?};
    //You have to add something here
    info!(&ctx, "tracepoint sys_enter_execve called {:x}", _filename_src_addr as u32);
    Ok(0)
}
```{{copy}}

* You can use a helper function: **bpf_probe_read_user_str_bytes** for that.
* You can have information about this helper function on the [documentation](https://docs.rs/aya-ebpf/latest/aya_ebpf/helpers/fn.bpf_probe_read_user_str_bytes.html).

![bpf_probe_read_user_str_bytes documentation](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/c6z41wt3r9hrzu53ihjv.png)

<br>

The helper function needs a buffer, so you should add:

```rust
let mut buf = [0u8; 16];
let _filename_bytes :&[u8] = unsafe { aya_ebpf::helpers::bpf_probe_read_user_str_bytes(_filename_src_addr, &mut buf)? };
```{{copy}}

* If you want to see the filename in bytes, you can replace the info log by:
```rust
info!(&ctx, "tracepoint sys_enter_execve called {:x} {:x}", _filename_src_addr as u32, _filename_bytes);
```{{copy}}


* cargo run should work:
```bash
cd /host/root/aya-test #In the container
RUST_LOG=info cargo run
```{{exec interrupt}}

You should see something like this:

![output of cargo run](../../img/aya-output-bytes.png)
