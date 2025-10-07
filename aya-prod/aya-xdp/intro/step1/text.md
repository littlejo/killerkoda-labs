Before coding an eBPF uprobe program with Aya, you need to install dependancies. I created a Docker Image for that to save time.

<br>

In this tutorial, you only can use **Editor** tab.

Launch this command in the Terminal at the bottom:

```sh
docker run --rm -it --name aya \
                    --privileged \
                    --network host \
                    -w /host/root/ \
                    -v /:/host \
                    -v /sys/kernel/debug:/sys/kernel/debug \
                    littlejo/aya:3.0.1 bash
```{{exec}}

* It can take a long time. During this time, you can install Rust extensions (in the OPEN VSX Registry) for the Editor:
  * Rust
  * Rust Syntax
  * Rust Extension Pack

Like that, in Rust code, you will see coloration of syntax.
![Rust plugin](../../img/plugin.png)

If you have time, you can also read the article: [Observability for All Developers with uProbes](https://blog.littlejo.link/en/ebpf-another-type/xdp/intro/).

![screenshot of the article](../../img/aya-article.png)
