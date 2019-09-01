# A 3-nodes centos/7 cluster

This is avery useful setup for a testing 3-nodes cluster. Each node has, two volumes (sda , sdb (10Gb by default))


> For vagrant: Make sure Secureboot is disabled (Bios)

Vagrant install (Ubuntu/Debian)

``` console
$ sudo apt-get install vagrant -y

$ sudo apt-get install linux-generic linux-signed-generic virtualbox virtualbox-dkms virtualbox-ext-pack -y
```

## Ssh considerations

Latest Vagrant version does not allow password auth inside of vagrant vms, you should use the private key provided by vagrant.

in the Vagrantfile directory for example

`ssh -i .vagrant/machines/node1/virtualbox/private_key vagrant@192.168.50.3`
