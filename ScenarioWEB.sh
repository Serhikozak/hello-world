#!/bin/bash
#Login and passwords
 RootPass="R@dikal"
 DB_Name="DBtask3"
 DB_User="Soulfire"
 DB_Pass="R@dikalf1re"

  sudo yum -y update
# Install Apache
  sudo yum -y install httpd
  sudo systemctl enable httpd
  sudo systemctl start httpd


  sudo firewall-cmd --permanent --zone=public --add-service=http
  sudo firewall-cmd --permanent --zone=public --add-service=https
  sudo firewall-cmd --reload

# install PHP 7.0
  sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
  sudo yum -y install yum-utils
  sudo yum-config-manager --enable remi-php70
  sudo yum -y install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo php-xml php-intl php-mbstring php-xmlrpc php-soap
 
# Install Moodle 3.2.1
 
wget https://download.moodle.org/download.php/direct/stable32/moodle-3.2.1.tgz
sudo tar -zxvf moodle-3.2.1.tgz -C /var/www/html
sudo chown -R apache:apache /var/www/html/moodle
sudo cmod 755 /var/www/html

sudo mkdir /var/www/moodledata
sudo chown -R apache:apache /var/www/moodledata
sudo cmod -R 755 /var/www/moodledata
sudo systemctl restart httpd 

sudo cp /var/www/html/config-dist.php /var/www/html/config.php
sudo nano /var/www/html/config.php

