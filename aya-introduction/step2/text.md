
Aya needs some new features in Rust. So you need to configure Rust to access it.

<br>

### Solution

```plain
rustup default stable
rustup toolchain add nightly
rustup component add rust-src --toolchain nightly
```{{exec}}
