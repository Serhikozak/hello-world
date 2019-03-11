#!/bin/bash

echo -e "--install ANSIBLE\n"
sudo yum -y install ansible 
#ssh-keygen -t rsa -b 1024 -f /home/vagrant/.ssh/id_rsa
 ssh-copy-id username@remote_host
#sudo chmod 500 /home/vagrant/db/virtualbox/private_key 
#sudo chmod 500 /home/vagrant/web_k/virtualbox/private_key
#sudo chmod 500 /home/vagrant/web_s/virtualbox/private_key
#sudo chmod 500 /home/vagrant/.ssh/known_hosts
 
#nano /etc/ansible/hosts
cat <<EOF | sudo tee -a /etc/ansible/hosts
  [db]
  db ansible_ssh_host=192.168.56.160 ansible_user=vagrant
  [web]
  web_k ansible_ssh_host=192.168.56.170 ansible_user=vagrant
  web_s ansible_ssh_host=192.168.56.180 ansible_user=vagrant
EOF 

sudo cat <<EOF | sudo tee -a /etc/ansible/ansible.cfg
[defaults]
host_key_checking = false
inventory = /etc/ansible/hosts.txt
EOF