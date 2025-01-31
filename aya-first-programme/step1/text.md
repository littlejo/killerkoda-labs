Before coding an eBPF program with Aya, you need to install dependancies. I created an Docker Image for that to save time.

<br>

In this tutorial, you only can use **Editor** tab.

Launch this command in the Terminal at the bottom:

```plain
docker run --rm -it --name aya \
                    --privileged \
                    --network host \
                    -e USER=littlejo \
                    -e RUST_LOG=info \
                    -v /:/host \
                    -v /sys/kernel/debug:/sys/kernel/debug \
                    littlejo/aya:slim bash
```{{exec}}

