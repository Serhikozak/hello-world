#!/bin/bash
  sudo yum -y update
  sudo yum -y install haproxy
  sudo yum systemctl start haproxy
  sudo yum systemctl enable haproxy

#su
#pass:Vagrant
 #mkdir -p /etc/haproxy
 #mkdir -p /run/haproxy
 #mkdir -p /var/lib/haproxy
 #touch /var/lib/haproxy/stats
 #useradd -r haproxy
  
  sudo firewall-cmd --permanent --zone=public --add-service=http
  sudo firewall-cmd --permanent --zone=public --add-port=8181/tcp
  sudo firewall-cmd --reload


#sudo systemctl restart haproxy  