As your `main.rs` file grows, you need to split the code into smaller files.

Start by editing the empty `common.rs` file:

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

Then, update `main.rs` by replacing the maps (`BUF` and `EXCLUDED_CMDS`) and the constant (`ZEROED_ARRAY`) with:

```rust
mod common;
use crate::common::*;
```{{copy}}

Now your code has to compile:

```plain
cd /host/root/project
cargo run
```{{exec interrupt}}

