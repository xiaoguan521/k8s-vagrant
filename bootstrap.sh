#!/bin/bash

# 禁用Swap
sudo sed -i '/swap/d' /etc/fstab
sudo swapoff -a

# 配置防火墙规则
sudo ufw disable # 禁用防火墙
sudo modprobe br_netfilter
sudo sh -c "echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables"

# 禁用SELinux
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sudo setenforce 0

# Master node
if [ "$1" == "master" ]; then
  # Add hosts entry for Node1
  echo "192.168.41.10  master" >>/etc/hosts
  echo "192.168.41.11  node1" >>/etc/hosts 

fi

# Worker node
if [ "$1" == "worker" ]; then
  # Add hosts entry for Node1
  echo "192.168.41.10  master" >>/etc/hosts
  echo "192.168.41.11  node1" >>/etc/hosts  
fi

# 更新系统
sudo apt-get update
sudo apt-get upgrade -y

# 安装Docker
# sudo apt-get update
# sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
# sudo apt-get update
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# # Add current user to the docker group
# sudo usermod -aG docker $USER

# # Enable and start Docker service
# sudo systemctl enable docker.service
# sudo systemctl start docker.service

# Configure Docker to use systemd as the cgroup driver
# sudo mkdir -p /etc/docker
# sudo tee /etc/docker/daemon.json <<EOF
# {
#   "registry-mirrors": [
#   "https://docker.mirrors.ustc.edu.cn",
#   "https://hub-mirror.c.163.com",
#   "https://reg-mirror.qiniu.com",
#   "https://registry.docker-cn.com"
#   ],
#   "exec-opts": ["native.cgroupdriver=systemd"]
# }
# EOF

# # Restart Docker service
# sudo systemctl daemon-reload
# sudo systemctl restart docker.service

# Switch to root user
sudo su -
# Set root password
echo "root:vagrant" | sudo chpasswd
# Enable password authentication in SSH
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
# Permit root login in SSH
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# Restart SSH service
sudo systemctl restart sshd

###Install GO###
# wget https://storage.googleapis.com/golang/getgo/installer_linux
# chmod +x ./installer_linux
# ./installer_linux
# source ~/.bash_profile
# # 安装kubeadm、kubelet和kubectl
# sudo apt-get install -y apt-transport-https curl
# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
# sudo apt-get update
# sudo apt-get install -y kubeadm kubelet kubectl
# sudo systemctl enable kubelet
# sudo systemctl start kubelet
