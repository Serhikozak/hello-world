#!/usr/bin/bash

#Login and passwords
 RootPass="R@dikal"
 DB_Name="DBtask3"
 DB_User="Soulfire"
 DB_Pass="R@dikalf1re"

sudo yum -y update

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
sudo mysql -e"CREATE USER ${DB_User} IDENTIFIED BY ${DB_Pass};"
sudo mysql -e"CREATE DATABASE ${DB_Name}"
sudo mysql -e"DEFAULT CHARACTER SET UTF8 COLLATE utf8_unicode_ci;"
sudo mysql -e"GRANT ALL PRIVILEGES ON ${DB_Name}.* TO ${DB_User};"
sudo mysql -e"FLUSH PRIVILEGES;"
sudo mysql -e"SET GLOBAL innodb_file_format = 'BARRACUDA';"
sudo mysql -e"SET GLOBAL innodb_large_prefix = 'ON';"
sudo mysql -e"SET GLOBAL innodb_file_per_table = 'ON';"
#install php
sudo yum -y install php php-mysql
sudo systemctl restart httpd.service
sudo yum -y install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo php-xml php-intl php-mbstring php-xmlrpc php-soap
#sudo vi /var/www/html/info.php <?php phpinfo(Hallo); ?> :wq


sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

#download and install LMS moodle
sudo yum -y install wget
sudo wget https://download.moodle.org/download.php/stable36/moodle-latest-36.tgz 
sudo tar -zxvf moodle-latest-36.tgz -C/var/www/html

sudo chown -R apache:apache /var/www/html/moodle/
sudo mkdir /var/moodle
sudo mkdir /var/moodle/data 
sudo chown -r apache:apache /var/moodle
sudo chmod -r 755/var/moodle
sudo cd /var/www/html/moodle/





