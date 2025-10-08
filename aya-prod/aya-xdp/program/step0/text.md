<br>

xdp-tools is installed on the container. You can test it:

For example:

```sh
xdp-filter load veth0
```{{exec}}

This program should print what you write on bash in the terminal

Open another terminal with split:
![split](../../img/screenshot-split.png)

Let's ping:
```sh
ip netns exec lb ping -c 3 10.0.0.1
```{{exec}}

In the container, you can see the status of XDP program:

```sh
xdp-filter status
```{{exec}}

In the container, you can filter lb namespace like this:
```sh
xdp-filter ip -m src 10.0.0.10
```{{exec}}


In the host, let's ping again:
```sh
ip netns exec lb ping -c 3 10.0.0.1
```{{exec}}

To remove the rule you can use `-r` option:
```sh
xdp-filter ip -r -m src 10.0.0.10
```{{exec}}

To unload xdp program you can type:
```sh
xdp-filter unload veth0
```{{exec}}
