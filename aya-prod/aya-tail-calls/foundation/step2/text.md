Now, you need to create additional eBPF programs. For now, they will be identical to `hook.rs` but with different names.

* Create the filter program:

```bash
cp /host/root/project/tracepoint-binary-ebpf/src/hook.rs /host/root/project/tracepoint-binary-ebpf/src/filter.rs
sed -i 's/tracepoint_binary/tracepoint_binary_filter/' /host/root/project/tracepoint-binary-ebpf/src/filter.rs
```{{exec interrupt}}

* Create the `display` program:  

```bash
cp /host/root/project/tracepoint-binary-ebpf/src/hook.rs /host/root/project/tracepoint-binary-ebpf/src/display.rs
sed -i 's/tracepoint_binary/tracepoint_binary_display/' /host/root/project/tracepoint-binary-ebpf/src/display.rs
```{{exec interrupt}}

* Register these new modules in `main.rs`:  

```rust
mod filter;
mod display;
```{{copy}}

* Ensure your code compiles successfully:

```plain
cd /host/root/project
RUST_LOG=info cargo run
```{{exec interrupt}}

At this stage, you've created two new eBPF programs (`filter` and `display`), but they are not yet attached to the kernel. The next step will be to load and manage them properly. 🚀
