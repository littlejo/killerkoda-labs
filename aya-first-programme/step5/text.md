Now you have to read the address to have the filename byte

You have to modified kernel space program: `aya-test-ebpf/src/main.rs`

Particularly this code:
```rust
fn try_test_aya(ctx: TracePointContext) -> Result<u32, i64> {
    let _filename_src_addr = unsafe {ctx.read_at::<*const u8>(16)?};
    info!(&ctx, "tracepoint sys_enter_execve called");
    Ok(0)
}
```{{copy}}

You can use a helper function: **bpf_probe_read_user_str_bytes** for that
You can have information about this helper function: https://docs.rs/aya-ebpf/latest/aya_ebpf/helpers/fn.bpf_probe_read_user_str_bytes.html

<br>

The helper function needs a buffer, so you should add:

```rust
let mut buf = [0u8; 16];
let _filename_bytes :&[u8] = unsafe { aya_ebpf::helpers::bpf_probe_read_user_str_bytes(_filename_src_addr, &mut buf)? };
```{{copy}}

* cargo run should work:
```bash
cd /host/root/aya-test #In the container
RUST_LOG=info cargo run
```{{exec}}
