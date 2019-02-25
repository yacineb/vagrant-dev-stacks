echo Install kubernetes
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl

echo kubelet requires swap off
swapoff -a
echo keep swap off after reboot
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
echo "Patchin 10-kubeadm.conf"
sed -i '/ExecStart=/a Environment="KUBELET_EXTRA_ARGS=--cgroup-driver=cgroupfs"' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

# Get the IP address that VirtualBox has given this VM
IPADDR=`ip -4 -o addr show scope global | grep -v 10.0.2.15 | head -1 | awk '{print $4}' | sed 's/\(.*\)\/.*/\1/'`
echo This VM has IP address $IPADDR

echo Set up Kubernetes
NODENAME=$(hostname -s)
kubeadm init --apiserver-cert-extra-sans=$IPADDR  --node-name $NODENAME --ignore-preflight-errors=all