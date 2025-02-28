You need to add a new feature: create a filter to exclude logs from certain binaries:
* `/usr/bin/git`
* `/opt/theia/node`

How to do this ?

* Kernel environment: Create an eBPF map with the list of binaries
* User environment: Fill up the eBPF map
* Kernel environment: Create a check if the binary is in the list
