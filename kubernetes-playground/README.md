# Kubernetes Cheat Sheet

Kubernetes master minimum requirements : CPUs=2, Memory=2048MB, Disk=20000MB

# Install kubectl

<https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl>

> make sure you have kubectl in PATH

## minikube (Debian/Ubuntu)

``` console
$ apt-get install virtualbox

$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
$ cp minikube /usr/local/bin && rm minikube

$ minikube version
$ minikube start

$ #enable dashboard
$ minikube dashboard
```  

# k8s client (kubectl)

- Full dump of cluster logs : `kubectl cluster-info dump`
- Nodes status : `kubectl get nodes`
- Pods status: `kubectl get pods`
- Services : `kubectl get services`
> use -n 'namespace' to run on a specific namespace
- Expose a service(Nodeport): `kubectl expose deployment http --external-ip="172.17.0.8" --port=8000 --target-port=80`

- test deployment creation `kubectl create deployment http --image=katacoda/docker-http-server:latest --replicas=1`
- dump deployment info : `kubectl describe deployment http `