#!/bin/bash
#install docker scenario from file Using_Docker_RUS.pdf
curl https://get.docker.com > /tmp/install.sh
cat /tmp/install.sh
chmod +x /tmp/install.sh
/tmp/install.sh
#switch off SELinux enforce
sudo setenforce 0
#create groupe docker
sudo usermod -aG docker $USER
sudo service docker restart