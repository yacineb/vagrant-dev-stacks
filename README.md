# vagrant-dev-stacks

A set of cool vagrant files for several developer stacks, there are useful for Testing, POCs and CI

Vagrant is an awesome tool developed by hashicorp, used for provisionning, running and sharing Vms based on official (or custom images built using [packer](https://www.packer.io/)). 

It's a straightforward tool for building development environments quickly.

> Vms in the examples are based on VirtualBox which is supported out of the box. However it's easy to change the Hypervisor, many hypervisors are supported: <https://www.vagrantup.com/docs/providers/>


## Prerequisties

You have to ensure vagrant tool is installed, some of [install instructions](https://www.vagrantup.com/docs/installation/)


**Windows**: using [chocolatey](https://chocolatey.org/install) package manager

``` console
$ choco install vagrant
```

**Ubuntu/Debian**

``` console
$ sudo apt-get install vagrant
```

## Samples

- To provision a vm you simply have to cd into a sample folder and run `vagrant up`
- run `vagrant destroy` to stop and clean a vm

Created vms are accessible via ssh protocol, Vagrant takes care of ssh setup, no need to configure anything!

### __dotnetcore-nodejs__

It's an example of development Vm for .NET/node developers.
Developing on sperate Vm keep developer's machine neat and avoid headaches caused by multiple installs (multiple node, python, .net versions etc..)


### __kubernetes-playground__

A single node Kubernetes cluster. It's installed using kubeadm. 

Although [minikube](https://github.com/kubernetes/minikube) is a recommended solution for Kubernetes testing. It's not production-grade and it's always preferable to have test environment the closest possible to production.  

> Once `vagrant up` is done you have to those 2 commands below to finish cluster setup:

``` console

$ #install weave network
$ vagrant ssh -- "kubectl apply -f https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

$ # untaint : allows pods to be ran on master node
$ vagrant ssh -- "kubectl taint nodes --all node-role.kubernetes.io/master-"
```

> You can check kubernetes cluster status using those commands below

``` console
$ vargrant ssh -- kubectl version
$ vagrant ssh -- kubectl get nodes
```

## __couchdb-dev__

A simple illustration of docker provisionning inside a vagrant vm.
