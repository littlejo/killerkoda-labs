
Check installation on an example

<br>

```plain
git clone https://github.com/aya-rs/book.git
cd book/examples/kprobetcp/
```{{exec}}

```plain
RUST_LOG=info cargo run
```{{exec}}

On another terminal:
```plain
RUST_LOG=info curl 1.1.1.1
```{{exec}}

* Look what you see on the other terminal.
