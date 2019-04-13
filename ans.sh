#!/bin/bash

sudo yum -y update
sudo yum -y install mc
sudo yum -y install epel-release
sudo yum -y install ansible
sudo mkdir /home/vagrant/hosts
#sudo mkdir /home/vagrant/ansible/playbook

#sudo mkdir /home/vagrant/ansible/playbook/ansible.cfg


cat <<EOF | sudo tee -a /home/vagrant/hosts
       
 #web ansible_host=127.0.0.1 ansible_port=2222 ansible_user=vagrant  ansible_private_key_file=.vagrant/machines/web/virtualbox/private_key
 default ansible_host=localhost ansible_user=vagrant ansible_connection=local
  
EOF
 #ansible --version
#sudo yum install openssh-server -y

#cat <<EOF | sudo tee -a /etc/ansible/ansible.cfg
        
#inventory=hosts
#remote_user=vagrant
#ansible_private_key_file=.vagrant/machines/web/virtualbox/private_key
#host_key_checking=False

 #[inventory]
#enable_plugins = host_list, script, yaml, ini, auto
#EOF




#sudo chmod 600 /home/vagrant/.ssh/web_key
#sudo sed -i -e '/#inventory=/etc/ansible/hosts/inventory=/etc/ansible/g' /etc/ansible/ansible.cfg
#sudo sed -i -e 's/#host_key_checking = false/host_key_checking = false/g' /etc/ansible/ansible.cfg
#sudo sed -i -e 's/#enable_plugins = host_list, script, yaml, ini, auto/enable_plugins = host_list, script, yaml, ini, auto/g' /etc/ansible/ansible.cfg
#ansible-playbook -e 'host_key_checking=False' ja.yml
#ansible-playbook -e 'inventory' ja.yml
#ansible-playbook ~/playbook/ja.yml -i  'web'

#ansible-playbook /vagrant/web.yml -i /etc/ansible/hosts
#ansible-playbook /vagrant/playbook/Java.yml -i /etc/ansible/hosts
#ansible-playbook /vagrant/jenk.yml -i /etc/ansible/hosts
#ansible-playbook /vagrant/maven.yml -i /etc/ansible/hosts 