Before coding an eBPF program with Aya, you need to install dependancies. I created an Docker Image for that to save time.

<br>

### Solution

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

