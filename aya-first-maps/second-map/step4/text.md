Now you have to Create a check in the kernel environment if the binary is in the list

For that, we have to modify this file: `/root/tracepoint-binary/tracepoint-binary-ebpf/src/main.rs`

* Add these lines:
```rust
if EXCLUDED_CMDS.get(& *buf).is_some() {
           info!(&ctx, "No log for this Binary");
           return Ok(0);
}
```{{copy}}

before this lines: `from_utf8_unchecked(filename_bytes)`
