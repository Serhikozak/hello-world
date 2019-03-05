#!/usr/bin/bash

#Login and passwords
 RootPass="dl"
 DB_Name="DBtask3"
 DB_User="moodleuser"
 DB_Pass="R@dikalf1re"

sudo yum -y update

#Instal PHP7.2
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install yum-utils
sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum-config-manager --disable remi-php54
sudo yum-config-manager --enable remi-php73
sudo yum -y install php php-mcrypt php-cli php-gd php-curl php-ldap php-zip php-fileinfo php-xml php-intl php-mbstring php-xmlrpc php-soap php-fpm php-mysqlnd php-devel php-pear php-bcmath php-json
  
#install apache
sudo yum -y install httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

#install mariadb
sudo yum -y install mariadb-server mariadb
sudo systemctl start mariadb
#sudo /usr/bin/mysql_secure_installation -y root password ${RootPass}
sudo systemctl enable mariadb.service
sudo /usr/bin/mysqladmin -u root password ${RootPass}

#Create a MariaDB dataBase for Moodle
sudo mysql -uroot -p${RootPass} -e "CREATE DATABASE ${DB_Name} DEFAULT CHARACTER SET UTF8 COLLATE utf8_unicode_ci;"
sudo mysql -uroot -p${RootPass} -e "CREATE USER '${DB_User}'@localhost IDENTIFIED BY '${DB_Pass}';"
sudo mysql -uroot -p${RootPass} -e "GRANT ALL PRIVILEGES ON ${DB_Name}.* TO '${DB_User}'@localhost;"
sudo mysql -uroot -p${RootPass} -e "FLUSH PRIVILEGES;"
sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_file_format = 'BARRACUDA';"
sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_large_prefix = 'ON';"
sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_file_per_table = 'ON';"

#download and install LMS moodle
sudo yum -y install wget
sudo wget https://download.moodle.org/download.php/direct/stable36/moodle-latest-36.tgz 
sudo tar -xzvf moodle-latest-36.tgz -C /var/www/html/
#sudo chown -R apache:apache /var/www/html

#Setup a dedicated data directory for Moodle

#sudo cd /var/www/html/moodle/

#Setup a virtual host for Moodle
#sudo yum -y install nano
#sudo systemctl stop httpd
#cd /etc/httpd/conf.d/

sudo php /var/www/html/moodle/admin/cli/install.php --chmod=2770 \
 --lang=uk \
 --dbtype=mariadb \
 --wwwroot=http://192.168.56.110/moodle \
 --dataroot=/var/moodledata \
 --dbhost=localhost \
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
sudo chown -R apache:apache /var/moodledata
sudo chown -R apache:apache /var/www/
sudo systemctl restart httpd

sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload


#sudo cd /var/www/html/moodle/



#sudo systemctl restart httpd


