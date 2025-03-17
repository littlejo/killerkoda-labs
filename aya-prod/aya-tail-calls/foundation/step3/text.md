Now you need to fill the map of eBPF program. You have to do in the user environment.


```rust
let map = ebpf.take_map("JUMP_TABLE").unwrap();
let mut tail_call_map = ProgramArray::try_from(map)?;
```{{copy}}

```rust
use aya::maps::ProgramArray;
```{{copy}}

On `main.rs`, you need to add these lines:

```rust
let prg_list = ["tracepoint_binary_filter", "tracepoint_binary_display"];

for (i, prg) in prg_list.iter().enumerate() {
    {
        let program: &mut TracePoint = ebpf.program_mut(prg).unwrap().try_into()?;
        program.load()?;
        let fd = program.fd().unwrap();
        tail_call_map.set(i as u32, fd, 0)?;
    }
}
```{{copy}}

Your code has to compile:
```plain
cd /host/root/project
RUST_LOG=info cargo run
```{{exec interrupt}}


