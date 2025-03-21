You need to install Rust along with all the required tools using rustup.

* So install Rustup like that:

```plain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```{{exec}}

* Answer `1) Proceed with standard installation (default - just press enter)`

* It can take a long time. During this time, you can read the article: [Let's introduce eBPF and Aya](https://dev.to/littlejo/lets-introduce-ebpf-and-aya-40ji).

![screenshot of the article](../img/aya-article.png)

To ensure the correct binary path is set, run the following command: 

```plain
. "$HOME/.cargo/env"
```{{exec}}

