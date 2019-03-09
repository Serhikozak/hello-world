#!/bin/bash

#sudo yum info haproxy | grep Version
sudo yum -y update

sudo yum -y install mc make
sudo yum install wget gcc pcre-devel pcre-static -y

  echo -e "-- Download and unpack HAProxy\n"
wget http://www.haproxy.org/download/1.8/src/haproxy-1.8.8.tar.gz 
sudo tar -zxvf haproxy-1.8.8.tar.gz -C /usr/local/src 
cd /usr/local/src/haproxy-1.8.8

sudo make TARGET=generic ARCH=native CPU=x86_64 -j8
sudo make install
sudo cp examples/haproxy.init /etc/init.d/haproxy
chmod 755 /etc/init.d/haproxy
sudo systemctl daemon-reload

   sudo mkdir -p /etc/haproxy       
   sudo mkdir -p /run/haproxy 
   sudo mkdir -p /var/lib/haproxy 
   sudo touch /var/lib/haproxy/stats

#Create a Symbolic link for “/usr/local/sbin/haproxy” to “/usr/sbin/haproxy”   
  sudo ln -s /usr/local/sbin/haproxy /usr/sbin/haproxy

  sudo useradd -r haproxy

  echo -e "-- Configuring HAProxy\n"
sudo mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.old
cat <<EOF | sudo tee -a /etc/haproxy/haproxy.cfg
global
    log /dev/log local0
    log localhost local1 notice
    user haproxy
    group haproxy
    maxconn 2000
    daemon
 
defaults
    log global
    mode http
    option httplog
    option dontlognull
    retries 3
    timeout connect 5000
    timeout client 50000
    timeout server 50000
 
frontend http-in
    bind *:80
    default_backend webservers
 
backend webservers
    balance roundrobin
    stats enable
    stats auth admin:admin
    stats uri /haproxy?stats
    option httpchk
    option forwardfor
    option http-server-close
    server webserver1 192.168.56.111:80 check
    server webserver2 192.168.56.112:80 check
EOF

echo -e "-- Validating HAProxy configuration\n"
haproxy -f /etc/haproxy/haproxy.cfg -c
 sudo systemctl restart haproxy



 
  #sudo firewall-cmd --permanent --zone=public --add-service=http
  #sudo firewall-cmd --permanent --zone=public --add-port=8181/tcp
  #sudo firewall-cmd --reload


