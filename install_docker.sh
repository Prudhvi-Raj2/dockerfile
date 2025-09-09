#!/bin/bash
sudo growpart /dev/nvme0n1 4
sudo lvextend -l +50%FREE /dev/RootVG/rootVol
sudo lvextend -l +50%FREE /dev/RootVG/varVol
sudo xfs_growfs /
sudo xfs_growfs /var

#installing docker


sudo dnf update -y
sudo dnf install -y dnf-utils
sudo dnf -y install dnf-plugins-core
sudo sleep 10
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo sleep 10
sudo systemctl enable --now docker
sudo usermod -aG docker ec2-user

#kubectl installation
 