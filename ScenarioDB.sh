#!/usr/bin/bash
 #Login and passwords
 RootPass="R@dikal"
 DB_Name="DBtask3"
 DB_User="Soulfire"
 DB_Pass="R@dikalf1re"



  sudo yum -y update

  #Build the MariaDB 10.1 repo
  cat <<EOF | sudo tee -a /etc/yum.repos.d/MariaDB.repo
# MariaDB 10.1 CentOS repository list - created 2017-01-14 03:11 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

  #Install MariaDB 10.1 using YUM 
  sudo yum -y install mariadb-server
  sudo systemctl start mariadb
  sudo systemctl enable mariadb
  #Secure the installation of MariaDB
  sudo /usr/bin/mysql_secure_installation -y root password ${RootPass}  #? -y or -u
  #set root password
  #sudo /usr/bin/mysqladmin -u root password ${}
  #Create a MariaDB dataBase for Moodle
  mysql -u root -p${RootPass} -e \  #?
  CREATE DATABASE ${DB_Name} DEFAULT CHARACTER SET UTF8 COLLATE utf8_unicode_ci; \
  CREATE USER ${DB_User} IDENTIFIED BY ${DB_Pass};
  GRANT ALL PRIVILEGES ON ${DB_Name}.* TO ${DB_User} IDENTIFIED BY ${DB_Pass} WITH GRANT OPTION;
  FLUSH PRIVILEGES;
  EXIT;

  #firewall-cmd --add-port=3306/tcp 
  #firewall-cmd --permanent --add-port=3306/tcp
