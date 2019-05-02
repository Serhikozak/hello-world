#!/usr/bin/bash

# sudo yum -y update
sudo yum -y install nano wget tree mc

#Ansible
sudo yum -y install epel-release
sudo yum -y install ansible

sudo sed -i -e 's/#host_key_checking = False/host_key_checking = False/g' /etc/ansible/ansible.cfg


cat <<EOF | sudo tee -a /etc/ansible/hosts

localhost  ansible_host=localhost ansible_user=vagrant  ansible_connection=local
EOF

mkdir /tmp/nodejs
cd /vagrant

sudo ansible-playbook main.yml
#sudo rm /etc/ansible/ansible.cfg
#sudo chmod 400 ~/.ssh/*.pem

# sudo yum-config-manager \
#     --add-repo \
#     https://download.docker.com/linux/centos/docker-ce.repo

# sudo yum -y install docker-ce docker-ce-cli containerd.io  
# sudo systemctl start docker 
# sudo systemctl enable docker  
# # create the docker group and add your user:
# sudo groupadd docker
# sudo usermod -aG docker $USER
# #how to restart machines?
# sudo systemctl restart docker 

# #coretto JDK JRE
# sudo wget https://d1f2yzg3dx5xke.cloudfront.net/java-1.8.0-amazon-corretto-devel-1.8.0_202.b08-1.amzn2.x86_64.rpm
# sudo wget https://d1f2yzg3dx5xke.cloudfront.net/java-1.8.0-amazon-corretto-1.8.0_202.b08-1.amzn2.x86_64.rpm
# sudo yum -y localinstall java-1.8.0-amazon-corretto*.rpm

# sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
# sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# sudo yum -y install jenkins
# sudo systemctl start jenkins.service
# sudo systemctl enable jenkins.service



# sudo mkdir /opt/maven

#     sudo wget https://apache.volia.net/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz
#     sudo tar xzvf apache-maven-3.6.0-bin.tar.gz -C /opt/maven
#     sudo yum -y install maven
#     #setup the environment variables
#     sudo sh -c "echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64/jre' >> /etc/profile.d/maven.sh"
#     sudo sh -c "echo 'export M2_HOME=/opt/maven/apache-maven-3.6.0' >> /etc/profile.d/maven.sh"
#     sudo sh -c "echo 'export MAVEN_HOME=/opt/maven/apache-maven-3.6.0' >> /etc/profile.d/maven.sh"
#     sudo sh -c "echo 'PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh"
#     sudo chmod +x /etc/profile.d/maven.sh
#     #load the environment variables by typing
#     source /etc/profile.d/maven.sh

# sudo cat /var/lib/jenkins/secrets/initialAdminPassword > ~pass