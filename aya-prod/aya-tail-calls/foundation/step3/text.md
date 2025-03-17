Now, you're working in user space (`tracepoint-binary/src/main.rs`).

Your goal is to:

✅ Retrieve the eBPF map that you just created on the kernel side.

✅ Attach the eBPF programs in user space.

✅ Fill the eBPF map with these programs to enable tail calls.


### Retrieve the eBPF map

Add the following code before `let ctrl_c = signal::ctrl_c();`:

```rust
let map = ebpf.take_map("JUMP_TABLE").unwrap();
let mut tail_call_map = ProgramArray::try_from(map)?;
```{{copy}}

Also, **import the required library**:

```rust
use aya::maps::ProgramArray;
```{{copy}}

### Attach the eBPF programs and fill the map

Insert this snippet:

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

### Compile and run the code


* Ensure your code compiles successfully:
```plain
cd /host/root/project
cargo run
```{{exec interrupt}}

Now that the foundation for tail calls is in place, you need to refine the eBPF programs to make them fully functional.

🔹 Enable dynamic interaction between eBPF programs using tail calls
You'll modify the programs so they can chain execution dynamically through the JUMP_TABLE map.
🔹 Define a specific purpose for each eBPF program

Each program (filter and display) should have a clear, distinct role:
* filter: Apply filtering logic before processing events.
* display: Log or analyze relevant information after filtering.

By implementing these changes, your eBPF programs will collaborate efficiently, optimizing performance and flexibility. 🚀
