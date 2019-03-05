#!/usr/bin/bash

#Login and passwords
 RootPass="dl"
 DB_Name="DBtask3"
 DB_User="'moodleuser'@'localhost'"
 DB_Pass="R@dikalf1re"

sudo yum -y update

#Instal PHP7.2
  sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  sudo yum -y install yum-utils
  sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
  sudo yum-config-manager --enable remi-php70
  sudo yum -y install php72 php72-php-fpm php72-php-mysqlnd php72-php-opcache php72-php-xml php72-php-xmlrpc php72-php-gd php72-php-mbstring php72-php-json
  
#install apache
sudo yum -y install httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

#install mariadb
sudo yum -y install mariadb-server mariadb-client
sudo systemctl start mariadb
#sudo /usr/bin/mysql_secure_installation -y root password ${RootPass}
sudo systemctl enable mariadb.service
sudo /usr/bin/mysqladmin -u root password ${RootPass}

#Create a MariaDB dataBase for Moodle
mysql -u root -p${RootPass} 
sudo mysql -e"CREATE DATABASE ${DB_Name} DEFAULT CHARACTER SET UTF8 COLLATE utf8_unicode_ci;"
sudo mysql -e"CREATE USER ${DB_User} IDENTIFIED BY ${DB_Pass};"
sudo mysql -e"GRANT ALL PRIVILEGES ON ${DB_Name}.* TO ${DB_User};"
sudo mysql -e"FLUSH PRIVILEGES;"
sudo mysql -e"SET GLOBAL innodb_file_format = 'BARRACUDA';"
sudo mysql -e"SET GLOBAL innodb_large_prefix = 'ON';"
sudo mysql -e"SET GLOBAL innodb_file_per_table = 'ON';"
sudo mysql -e"EXIT;"

#download and install LMS moodle
sudo yum -y install wget
wget https://download.moodle.org/download.php/direct/stable36/moodle-latest-36.tgz 
sudo tar -xzvf moodle-latest-36.tgz -C/var/www/html/
sudo chown -R root:root /var/www/html

#Setup a dedicated data directory for Moodle
sudo mkdir /var/www/moodledata
sudo chown -R apache:apache /var/www/moodledata
sudo chmod -R 755/var/www/moodledata
#sudo cd /var/www/html/moodle/

#Setup a virtual host for Moodle
sudo yum -y install nano
#sudo systemctl stop httpd
#cd /etc/httpd/conf.d/
sudo nano /etc/httpd/conf.d/moodle.conf

 cat <<EOF | sudo tee -a /etc/httpd/conf.d/moodle.conf
<VirtualHost *:80>
ServerAdmin admin@moodle.com
DocumentRoot /var/www/html/moodle
ServerName moodle.com
ServerAlias www.moodle.com
Alias /moodle "/var/www/html/moodle/"
<Directory /var/www/html/moodle/>
Options FollowSymLinks
AllowOverride All
</Directory>
ErrorLog /var/log/httpd/moodle-error_log
CustomLog /var/log/httpd/moodle-access_log common
</VirtualHost>
EOF















sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload


#sudo cd /var/www/html/moodle/



sudo systemctl restart httpd

