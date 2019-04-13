#!/bin/bash
#install docker scenario from /docs.docker.com/install/linux
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum -y install docker-ce docker-ce-cli containerd.io  
sudo systemctl start docker  
# create the docker group and add your user:
sudo groupadd docker
sudo usermod -aG docker $USER
#how to restart machines?
sudo systemctl restart docker 
