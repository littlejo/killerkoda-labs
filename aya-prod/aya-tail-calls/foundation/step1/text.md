To enable tail calls, you need to create a [Program Array](https://docs.ebpf.io/linux/map-type/BPF_MAP_TYPE_PROG_ARRAY/) map. Add the following lines to `common.rs`:

```rust
#[map]
pub static JUMP_TABLE: ProgramArray = ProgramArray::with_max_entries(2, 0);
```{{copy}}

* This map will hold two entries:
  * filter
  * display

Also, make sure to update the library imports in `common.rs`:

```rust
use aya_ebpf::{
    macros::map,
    maps::{HashMap, PerCpuArray, ProgramArray},
};
```{{copy}}

Finally, ensure your code compiles correctly:

```plain
cd /host/root/project
cargo run
```{{exec interrupt}}
