You have to modified kernel space program: `aya-test-ebpf/src/main.rs`.

You need to reset the buf map. after `let filename = unsafe {` line, add this line:

```rust
*buf = [0u8; LEN_MAX_PATH];
```{{copy}}

* It should work now:
```bash
cd /host/root/project
RUST_LOG=info cargo run
```{{exec interrupt}}

* Open another terminal to test it

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
cd /host/root/project
RUST_LOG=debug cargo run
```{{exec interrupt}}
