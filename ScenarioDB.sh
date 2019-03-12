#!/usr/bin/bash
 #Login and passwords
 RootPass="mdb"
 DB_User="Soulfire"
 DB_Pass="Radikalfire"
 
  sudo yum -y update
  sudo yum -y install wget mc
  

  #Install MariaDB  
  sudo yum -y install mariadb-server mariadb
  sudo systemctl start mariadb
  sudo systemctl enable mariadb.service
  sudo /usr/bin/mysqladmin -uroot password ${RootPass}
  
  #Create a MariaDB dataBase for Moodle
  sudo mysql -uroot -p${RootPass} -e "SET GLOBAL character_set_server = 'utf8mb4';"
  sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_file_format = 'BARRACUDA';"
  sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_large_prefix = 'ON';"
  sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_file_per_table = 'ON';"
  
  sudo mysql -uroot -p${RootPass} -e "CREATE DATABASE dbtask2 ;"
  sudo mysql -uroot -p${RootPass} -e "CREATE USER '${DB_User}'@'%' IDENTIFIED BY '${DB_Pass}';"
  sudo mysql -uroot -p${RootPass} -e "GRANT ALL PRIVILEGES ON dbtask2.* TO '${DB_User}'@'%';"
  sudo mysql -uroot -p${RootPass} -e "FLUSH PRIVILEGES;"
    

  sudo systemctl enable firewalld
  sudo systemctl start firewalld
  sudo firewall-cmd --add-service=dbtask2
  sudo firewall-cmd --add-port=3306/tcp 
  sudo firewall-cmd --permanent --add-port=3306/tcp 
  
  
