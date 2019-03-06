#!/usr/bin/bash
 #Login and passwords
 RootPass="dl"
 DB_Name="DBtask2"
 DB_User="Soulfire"
 DB_Pass="Radikalfire"



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
  
  sudo /usr/bin/mysqladmin -u root password ${RootPass}
  sudo /usr/bin/mysqladmin -u root -h MDB password ${RootPass}
  #Create a MariaDB dataBase for Moodle
  sudo mysql -uroot -p${RootPass} -e "CREATE DATABASE ${DB_Name} DEFAULT CHARACTER SET UTF8 COLLATE utf8_unicode_ci;"
  sudo mysql -uroot -p${RootPass} -e "CREATE USER '${DB_User}'@localhost IDENTIFIED BY '${DB_Pass}';"
  sudo mysql -uroot -p${RootPass} -e "GRANT ALL PRIVILEGES ON ${DB_Name}.* TO '${DB_User}'@localhost;"
  sudo mysql -uroot -p${RootPass} -e "FLUSH PRIVILEGES;"
  sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_file_format = 'BARRACUDA';"
  sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_large_prefix = 'ON';"
  sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_file_per_table = 'ON';"

  sudo systemctl enable firewalld
  sudo systemctl start firewalld
  sudo firewall-cmd --permanent --zone=public --add-service=http
  sudo firewall-cmd --permanent --zone=public --add-service=https
  sudo firewall-cmd --add-port=3306/tcp 
  sudo firewall-cmd --permanent --add-port=3306/tcp
