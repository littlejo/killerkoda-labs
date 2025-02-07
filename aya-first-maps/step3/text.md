Now you have to improve the code to fix the problem of filename cut. Indeed, filename only have 15 characters.

You have to modify, this line:
```rust
const LEN_MAX_PATH: usize = 16;
```

Test with the value of 512.

In the container, run these commands:

```plain
cd /host/root/aya-examples/tracepoint-binary
RUST_LOG=info cargo run
```{{exec}}

* You should see an error.
  * Why ?

* Solution: an eBPF Map
