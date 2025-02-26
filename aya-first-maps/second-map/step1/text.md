Now you have to add a new feature: You create a filter not to log some binaries.

How to do this ?

* Kernel environment: Create an eBPF map with the list of binaries
* User environment: Fill up the eBPF map
* Kernel environment: Create a check if the binary is in the list
