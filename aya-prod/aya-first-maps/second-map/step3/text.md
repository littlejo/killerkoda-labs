Now you have to fill up the eBPF map in the **user environment**.

![Screenshot user code](../../img/screenshot-user.png)

For that, you have to modify this file: `tracepoint-binary/src/main.rs` after this line:

```rust
program.attach("syscalls", "sys_enter_execve")?;
```

![work flow of map: input](../../img/map-workflow-4.png)

* Add the list of binaries:
```rust
let exclude_list = ["/usr/bin/ls", "/usr/bin/sleep"];
```{{copy}}

![work flow of map: retrieve map](../../img/map-workflow-2.png)

* Retrieve eBPF map in the user environment:
```rust
let map = ebpf.map_mut("EXCLUDED_CMDS").unwrap();
let mut excluded_cmds :HashMap<&mut MapData, [u8; 512], u8> = HashMap::try_from(map)?;
//fill up the map
```{{copy}}

You need to add libraries at the beginning of the file:
```rust
use aya::maps::{HashMap, MapData};
```{{copy}}

![work flow of map: retrieve map](../../img/map-workflow-3.png)

* You need to create a function to convert a command into a list of bytes and zeros of length 512.
* You can add this code at the end of the file:

```rust
fn cmd_to_bytes(cmd: &str) -> [u8; 512] {
    let mut cmd_zero = [0u8; 512];
    let cmd_bytes = cmd.as_bytes();
    let len = cmd_bytes.len();
    cmd_zero[..len].copy_from_slice(cmd_bytes);
    cmd_zero
}
```{{copy}}

* create a loop to fill up the eBPF map, add this code after `//fill up the map`:
```rust
for cmd in exclude_list.iter() {
        let cmd_zero = cmd_to_bytes(cmd);
        excluded_cmds.insert(cmd_zero, 1, 0)?;
}
```{{copy}}

So the main change:
![main change screenshot](../../img/screenshot-mainchange.png)

* Now it should be compiled:
```bash
cd /host/root/project
RUST_LOG=info cargo run
```{{exec interrupt}}

* Nothing changed in the log! You just filled the eBPF map.
