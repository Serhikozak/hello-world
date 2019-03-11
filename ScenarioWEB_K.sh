#!/bin/bash
#Login and passwords
  DB_User="Soulfire"
  DB_Pass="Radikalfire"

  sudo yum -y update
# Install Apache
  sudo yum -y install httpd
  sudo systemctl enable httpd
  sudo systemctl start httpd
  
 #Instal PHP7.3
  sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  sudo yum -y install yum-utils
  sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
  sudo yum-config-manager --disable remi-php54
  sudo yum-config-manager --enable remi-php73
  sudo yum -y install php php-pecl-memcache php-mcrypt php-cli php-gd php-curl php-ldap php-zip php-fileinfo php-xml php-intl php-mbstring php-xmlrpc php-soap php-fpm php-mysqlnd php-devel php-pear php-bcmath php-json
  sudo systemctl restart httpd

echo -e "-- Create  index.html\n"
cat <<EOF | sudo tee -a /var/www/html/index.html
<html>
    <body>
        WEB_K
    </body>
</html>
EOF

cat <<EOF | sudo tee -a /var/www/html/index.php
<?php
phpinfo();
?>
EOF  
 # Install Moodle 3.2.1
  sudo yum -y install wget
  wget https://download.moodle.org/download.php/direct/stable36/moodle-latest-36.tgz
  sudo tar -zxvf moodle-latest-36.tgz -C /var/www/html
  
  sudo mkdir /var/www/moodledata
  sudo chmod -R 755 /var/www/moodledata
  sudo chown -R apache:apache /var/www/moodledata
  
  sudo chown -R apache:apache /var/www/html/moodle
  sudo chmod -R 755 /var/www/html/moodle
  sudo setenforce 0
  #config for connect remote DB
    sudo php /var/www/html/moodle/admin/cli/install.php --chmod=2777 \
    --lang=uk \
    --dbtype=mariadb \
    --wwwroot=http://192.168.56.111/moodle \
    --dataroot=/var/www/moodledata \
    --dbhost=192.168.56.110 \
    --dbname=dbtask2 \
    --dbuser=${DB_User} \
    --dbpass=${DB_Pass} \
    --fullname=Moodle \
    --shortname=moodle \
    --summary=Moodle \
    --adminpass=Admin1 \
    --non-interactive \
    --agree-license

  sudo chown apache:apache /var/www/html/moodle/config.php
  sudo systemctl restart httpd

  sudo systemctl enable firewalld
  sudo systemctl start firewalld
  sudo firewall-cmd --permanent --zone=public --add-service=http
  sudo firewall-cmd --permanent --zone=public --add-service=https
  sudo firewall-cmd --reload
