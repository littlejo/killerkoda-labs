wget -O /usr/local/bin/setup-namespaces.sh https://raw.githubusercontent.com/littlejo/eunomia.dev/refs/heads/main/docs/tutorials/42-xdp-loadbalancer/setup.sh
wget -O /usr/local/bin/teardown-namespaces.sh https://raw.githubusercontent.com/littlejo/eunomia.dev/refs/heads/main/docs/tutorials/42-xdp-loadbalancer/teardown.sh
chmod a+x /usr/local/bin/setup-namespaces.sh /usr/local/bin/teardown-namespaces.sh
docker pull littlejo/aya:3.0.1
