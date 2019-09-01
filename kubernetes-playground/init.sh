
K8S_VERSION=$(kubeadm version -o short)
IPADDR=192.168.50.15

echo 'will initialise the cluster with a known token to simplify the following steps.'
kubeadm init --token=102952.1a7dd4cc8d1f4cc5 --kubernetes-version $K8S_VERSION --apiserver-cert-extra-sans=$IPADDR --ignore-preflight-errors=all

echo 'set up for cli use'
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf

echo 'show cluster info'
kubectl cluster-info

echo 'deploy cni Weave network driver'
kubectl apply -f https://cloud.weave.works/k8s/net?k8s-version=$K8S_VERSION

echo 'deploy dashboard port is 8443'
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml

cat <<EOF | kubectl create -f - 
apiVersion: v1
kind: ServiceAccount
metadata:
name: admin-user
namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
name: admin-user
roleRef:
apiGroup: rbac.authorization.k8s.io
kind: ClusterRole
name: cluster-admin
subjects:
- kind: ServiceAccount
name: admin-user
namespace: kube-system
EOF

echo 'show k8s dashboard admin token'
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

echo 'enable pods deploy en master'
kubectl taint nodes --all node-role.kubernetes.io/master-

echo 'install Kubeless FaaS provider'
sh ./kubeless.sh

