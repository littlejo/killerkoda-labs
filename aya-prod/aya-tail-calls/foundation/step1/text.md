You need to create a map for the creation of tail calls

Add these lines to this file `common.rs`:

```rust
#[map]
pub static JUMP_TABLE: ProgramArray = ProgramArray::with_max_entries(2, 0);
```{{copy}}

* There are 2 entries:
  * filter
  * display

Don't forget to modify libraries:

```rust
use aya_ebpf::{
    macros::map,
    maps::{HashMap, PerCpuArray, ProgramArray},
};
```{{copy}}

```plain
cd /host/root/project
RUST_LOG=info cargo run
```{{exec interrupt}}
