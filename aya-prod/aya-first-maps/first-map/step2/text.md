Now you have to create an eBPF map. There are different types of eBPF map. For this case, you need a [PERCPU ARRAY](https://docs.ebpf.io/linux/map-type/BPF_MAP_TYPE_PERCPU_ARRAY/) eBPF map.

You have to modified kernel space program: `aya-test-ebpf/src/main.rs`.

After this code:

```rust
const LEN_MAX_PATH: usize = 512;
const FILENAME_OFFSET: usize = 16;
```

You have to add eBPF map.

To declare an eBPF map, you can read this [documentation about another type of eBPF map](https://docs.rs/aya-ebpf/latest/aya_ebpf/maps/xdp/struct.CpuMap.html):
```rust
#[map]
static MAP: CpuMap = CpuMap::with_max_entries(8, 0);
```

So for `PERCPU_ARRAY`:
```rust
#[map]
static BUF: PerCpuArray<[u8; LEN_MAX_PATH]> = PerCpuArray::with_max_entries(1, 0);
```{{copy}}

* You just one array of 512 entries by CPU:

![map of one array of 8 entries](../../img/first-map.png)

* You also need to declare library for that:

```rust
use aya_ebpf::maps::PerCpuArray;
use aya_ebpf::macros::map;
```{{copy}}

* The map is now created. Now we have to use it.

This code does not compile yet because you need to replace the buffer: `let mut buf = [0u8; LEN_MAX_PATH];`

So if you want to test the code, you can temporarily replace this line by:
```rust
let mut buf = [0u8; 16];
```{{copy}}

Now it will compile:

```plain
cd /host/root/project
RUST_LOG=info cargo run
```{{exec interrupt}}
