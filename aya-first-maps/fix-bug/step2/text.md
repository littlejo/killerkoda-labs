Now you have to modify the eBPF map for buffer.

You have to modified kernel space program: `aya-test-ebpf/src/main.rs`.

Replace this code:

```rust
static BUF: PerCpuArray<[u8; LEN_MAX_PATH]> = PerCpuArray::with_max_entries(1, 0);
```

by:

```rust
static BUF: PerCpuHashMap<u8, [u8; LEN_MAX_PATH]> = PerCpuHashMap::with_max_entries(1, 0);
```{{copy}}

Also replace the library:
```rust
use aya_ebpf::maps::PerCpuArray;
```

by:

```rust
use aya_ebpf::maps::PerCpuHashMap;
```{{copy}}

At the beginning of the program ie after this line:
```rust
fn try_tracepoint_binary(ctx: TracePointContext) -> Result<u32, i64> {
```{{copy}}

reset the map like that:

```rust
BUF.insert(&0, &[0u8; 512], 0)?;
```{{copy}}


Replace the code:
```rust
let buf = BUF.get_ptr_mut(0).ok_or(0)?;
```

by:

```rust
let buf = BUF.get_ptr_mut(&0).ok_or(0)?;
```{{copy}}

* It should works now:
```bash
cd /host/root/tracepoint-binary
RUST_LOG=info cargo run
```{{exec}}
