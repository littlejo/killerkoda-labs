Before creating tail calls with Aya, you need to install dependancies. I created a Docker Image for that to save time.

<br>

In this lab, you only can use **Editor** tab. The project directory is `project`.

Launch this command in the Terminal at the bottom:

```plain
docker run --rm -it --name aya \
                    --privileged \
                    --network host \
                    -e USER=littlejo \
                    -e RUST_LOG=info \
                    -v /:/host \
                    -v /sys/kernel/debug:/sys/kernel/debug \
                    littlejo/aya:slim-cache-cache bash
```{{exec}}

* It can take a long time. During this time, you can install Rust extensions (in the OPEN VSX Registry) for the Editor:
  * Rust
  * Rust Syntax
  * Rust Extension Pack

Like that, in Rust code, you will see coloration of syntax.
![Rust plugin](../../img/plugin.png)

If you have time, you can also read the article: [TO WRITE](https://dev.to/littlejo/enhancing-your-aya-program-with-ebpf-maps-4hdj)

![screenshot of the article](../../img/aya-article.png)
