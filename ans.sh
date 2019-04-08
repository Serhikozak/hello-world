#!/bin/bash

sudo yum -y update
sudo yum -y install mc
sudo yum -y install epel-release
sudo yum -y install ansible


 #ansible --version
#sudo yum install openssh-server -y

cat <<EOF | sudo tee -a /etc/ansible/hosts
       
       web ansible_host=192.168.56.111 ansible_user=vagrant  ansible_ssh_private_key_file=/home/vagrant/.ssh/web_key
       #[ans]
       #java ansible_host=localhost ansible_user=vagrant ansible_connection=local
       #web_server ansible_host=localhost ansible_user=vagrant ansible_connection=local
       #ci ansible_host=localhost ansible_user=vagrant ansible_connection=local
       #mvn ansible_host=localhost ansible_user=vagrant ansible_connection=local

EOF
sudo chmod 600 /home/vagrant/.ssh/web_key
#sudo sed -i -e 's/#host_key_checking = false/host_key_checking = false/g' /etc/ansible/ansible.cfg
ansible-playbook -e 'host_key_checking=False' ja.yml
#ansible-playbook /vagrant/ja.yml -i  /etc/ansible/hosts
#ansible-playbook /vagrant/web.yml -i /etc/ansible/hosts
#ansible-playbook /vagrant/Java.yml -i /etc/ansible/hosts
#ansible-playbook /vagrant/jenk.yml -i /etc/ansible/hosts
#ansible-playbook /vagrant/maven.yml -i /etc/ansible/hosts 