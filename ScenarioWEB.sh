#!/bin/bash
#Login and passwords
 RootPass="dl"
 DB_Name="DBtask2"
 DB_User="Soulfire"
 DB_Pass="Radikalfire"

  sudo yum -y update
# Install Apache
  sudo yum -y install httpd
  sudo systemctl enable httpd
  sudo systemctl start httpd


  sudo firewall-cmd --permanent --zone=public --add-service=http
  sudo firewall-cmd --permanent --zone=public --add-service=https
  sudo firewall-cmd --reload

 #Instal PHP7.3
  sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  sudo yum -y install yum-utils
  sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
  sudo yum-config-manager --disable remi-php54
  sudo yum-config-manager --enable remi-php73
  sudo yum -y install php php-mcrypt php-cli php-gd php-curl php-ldap php-zip php-fileinfo php-xml php-intl php-mbstring php-xmlrpc php-soap php-fpm php-mysqlnd php-devel php-pear php-bcmath php-json
  sudo systemctl restart httpd
  
  
  sudo chcon -R -t httpd_sys_rw_content_t /var/moodledata
  sudo chown -R apache:apache /var/moodledata

# Install Moodle 3.2.1
  sudo yum -y install wget
  wget https://download.moodle.org/download.php/direct/stable36/moodle-latest-36.tgz
  sudo tar -zxvf moodle-latest-36.tgz -C /var/www/html
  
  sudo php /var/www/html/moodle/admin/cli/install.php --chmod=2770 \
 --lang=uk \
 --dbtype=mariadb \
 --wwwroot=http://192.168.56.111/moodle \
 --dataroot=/var/moodledata \
 --dbhost=192.168.56.110 \
 --dbname=${DB_Name} \
 --dbuser=${DB_User} \
 --dbpass=${DB_Pass} \
 --fullname=Moodle \
 --shortname=moodle \
 --summary=Moodle \
 --adminpass=Admin1 \
 --non-interactive \
 --agree-license
  sudo chmod o+r /var/www/html/moodle/config.php
  sudo chcon -R -t httpd_sys_rw_content_t /var/moodledata

  
  sudo chown -R apache:apache /var/www/
  sudo systemctl restart httpd


  sudo systemctl enable firewalld
  sudo systemctl start firewalld
  sudo firewall-cmd --permanent --zone=public --add-service=http
  sudo firewall-cmd --permanent --zone=public --add-service=https
  sudo firewall-cmd --reload
