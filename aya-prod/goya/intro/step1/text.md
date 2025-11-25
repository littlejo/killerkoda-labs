You can skip creating network namespaces if you want to test a program type other than XDP or TC.

### 🧠 Setting up your XDP development environment

Before coding an XDP program with Goya, you need to set up a suitable development environment.
We’ll use two components:

* a script to create network namespaces
* a Docker image that already contains all Rust dependencies

<br>

In this tutorial, you can only use the **Editor** tab.

### 🧩 Step 1 — Create network namespaces

Run the following script in the **terminal at the bottom** of the page:

```sh
setup-namespaces.sh
```{{exec}}

![lb h2 h3 namespaces](https://blog.littlejo.link/assets/svg/xdp/namespaces.svg)

* To list all namespaces created:

```sh
ip netns
```{{exec}}

* To see IPs on one namespace, for example `lb`:

```sh
ip netns exec lb ip -brief -family inet addr
```{{exec}}

---

### 🐳 Step 2 — Start the Docker container

Then, launch the following command:

```sh
docker run --rm -it --name goya \
  --privileged \
  --network host \
  -w /host/root/ \
  -v /:/host \
  -v /sys/kernel/debug:/sys/kernel/debug \
  -v /var/run/netns:/var/run/netns \
  -v /sys/fs/bpf/:/sys/fs/bpf/ \
  littlejo/aya:goya bash
```{{exec}}

> 📝 **Note:**
> The container mounts several host directories (`/sys/fs/bpf`, `/sys/kernel/debug`, `/var/run/netns`) so that it can access BPF maps, debug information, and host network namespaces — which are required to run XDP programs.

---

### 🔁 Step 3 — Resetting the environment

If you need to reset everything:

1. Quit the Docker container (`CTRL-D`)
2. On the **host**, remove the namespaces:
   ```sh
   teardown-namespaces.sh
   ```{{exec}}
3. On the **host**, recreate them:
   ```sh
   setup-namespaces.sh
   ```{{exec}}
4. Relaunch the container:
   ```sh
   docker run --rm -it --name goya \
     --privileged \
     --network host \
     -w /host/root/ \
     -v /:/host \
     -v /sys/kernel/debug:/sys/kernel/debug \
     -v /var/run/netns:/var/run/netns \
     -v /sys/fs/bpf/:/sys/fs/bpf/ \
     littlejo/aya:goya bash
   ```{{exec}}

---

### ⚙️ Optional — Improve your Editor experience

> ⏳ This setup can take a few minutes.
> In the meantime, you can install the following **Rust and Go extensions** (from the Open VSX Registry) in the Editor:
>
> - **Rust**
> - **Rust Syntax**
> - **Rust Extension Pack**
> - **Go syntax**

This will enable syntax highlighting for Rust code.
![Rust plugin](../../img/plugin.png)
