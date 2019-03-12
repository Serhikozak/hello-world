#!/bin/bash

# Install Apache
  sudo yum -y install httpd
  sudo systemctl enable httpd
  sudo systemctl start httpd
  #sudo firewall-cmd --permanent --zone=public --add-service=http
  #sudo firewall-cmd --permanent --zone=public --add-service=https
  #sudo firewall-cmd --reload

# install PHP 7.0
  sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
  sudo yum -y install yum-utils
  sudo yum-config-manager --enable remi-php70
  sudo yum -y install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo php-xml php-intl php-mbstring php-xmlrpc php-soap