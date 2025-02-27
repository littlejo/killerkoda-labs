Aya requires some new features in Rust, so you need to configure Rust to enable them.

<br>

### Solution

```plain
rustup default stable
rustup toolchain add nightly
rustup component add rust-src --toolchain nightly
```{{exec}}
