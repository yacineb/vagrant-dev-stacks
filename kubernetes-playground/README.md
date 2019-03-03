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


## Migrate from docker-compose

You can use [Kompose](https://github.com/kubernetes/kompose) it works like a charm

## Networking

- **Ingress** : Load-balancing and routing logic in k8s. it's handled by a plugin to be installed as a K8s service (Nginx, Traefic, etc)

- **Cluster IP** : the default approach when creating a Kubernetes Service. The service is allocated an internal IP that other components can use to access the pods.
By having a single IP address it enables the service to be load balanced across multiple Pods.

- **Target Port** : allows to separate the port the service is available on from the port the application is listening on. TargetPort is the Port which the application is configured to listen on. Port is how the application will be accessed from the outside.

- **Node port** : while TargetPort and ClusterIP make it available to inside the cluster, the NodePort exposes the service on each Node’s IP via the defined static port. No matter which Node within the cluster is accessed, the service will be reachable based on the port number defined.

- **External Ips** : Another approach to making a service available outside of the cluster is via External IP addresses.