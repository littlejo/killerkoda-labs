As your code in `main.rs` grow up, you need to split the code into small files.

Create a file `common.rs`:

```rust
use aya_ebpf::{
    macros::map,
    maps::{HashMap, PerCpuArray},
};

use tracepoint_binary_common::MAX_PATH_LEN;

pub const ZEROED_ARRAY: [u8; MAX_PATH_LEN] = [0u8; MAX_PATH_LEN];

#[map]
pub static BUF: PerCpuArray<[u8; MAX_PATH_LEN]> = PerCpuArray::with_max_entries(1, 0);

#[map]
pub static EXCLUDED_CMDS: HashMap<[u8; 512], u8> = HashMap::with_max_entries(10, 0);
```{{copy}}

On `main.rs`, you need to remove the map and the constant and add:

```rust
mod common;
use crate::common::*;
```{{copy}}

Your code has to compile:

```plain
cd /host/root/project
RUST_LOG=info cargo run
```{{exec interrupt}}

