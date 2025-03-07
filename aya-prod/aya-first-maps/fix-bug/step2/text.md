You have to modified kernel space program: `aya-test-ebpf/src/main.rs`.

You need to reset the buf map. after `unsafe {` line, add this line: 

```rust
*buf = [0u8; 512];
```{{copy}}

* It should work now:
```bash
cd /host/root/tracepoint-binary
RUST_LOG=info cargo run
```{{exec interrupt}}

Now you can replace info log into debug:
```rust
debug!(&ctx, "No log for this Binary");
```{{copy}}

Don't forget to add this library:

```rust
use aya_log_ebpf::debug;
```{{copy}}

* If you want to test with debug:
```bash
cd /host/root/tracepoint-binary
RUST_LOG=debug cargo run
```{{exec interrupt}}
