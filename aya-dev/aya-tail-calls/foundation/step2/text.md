As your code in `main.rs` grow up, you need to split the code into small files.


```plain
cp /host/root/project/tracepoint-binary-ebpf/src/hook.rs /host/root/project/tracepoint-binary-ebpf/src/filter.rs
sed -i 's/tracepoint_binary/tracepoint_binary_filter/' /host/root/project/tracepoint-binary-ebpf/src/filter.rs
```{{exec interrupt}}

```plain
cp /host/root/project/tracepoint-binary-ebpf/src/hook.rs /host/root/project/tracepoint-binary-ebpf/src/display.rs
sed -i 's/tracepoint_binary/tracepoint_binary_display/' /host/root/project/tracepoint-binary-ebpf/src/display.rs
```{{exec interrupt}}

On `main.rs`, you need to add these lines:

```rust
mod filter;
mod display;
```{{copy}}

Your code has to compile:
```plain
cd /host/root/project
RUST_LOG=info cargo run
```{{exec interrupt}}


