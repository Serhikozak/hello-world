#!/usr/bin/bash
 #Login and passwords
 RootPass="dl"
 DB_Name="DBtask2"
 DB_User="Soulfire"
 DB_Pass="Radikalfire"
 #MDB_Name="DBtask2"
 #MDB_User="Soulfire"
 


  sudo yum -y update

  
  #Install MariaDB  
  sudo yum -y install mariadb-server
  sudo systemctl start mariadb
  sudo systemctl enable mariadb
  sudo /usr/bin/mysqladmin -uroot password ${RootPass}
  #sudo /usr/bin/mysqladmin -u root -h MDB password ${RootPass}

  #Create a MariaDB dataBase for Moodle
  sudo mysql -uroot -p${RootPass} -e "CREATE DATABASE ${DB_Name} DEFAULT CHARACTER SET UTF8 COLLATE utf8_unicode_ci;"
  sudo mysql -uroot -p${RootPass} -e "CREATE USER '${DB_User}'@'192.168.56.111 IDENTIFIED BY '${DB_Pass}'';"
  sudo mysql -uroot -p${RootPass} -e "GRANT ALL PRIVILEGES ON ${DB_Name}.* TO '${DB_User}'@'192.168.55.111';"
  sudo mysql -uroot -p${RootPass} -e "FLUSH PRIVILEGES;"
  sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_file_format = 'BARRACUDA';"
  sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_large_prefix = 'ON';"
  sudo mysql -uroot -p${RootPass} -e "SET GLOBAL innodb_file_per_table = 'ON';"
  
  
  #sudo mysql -uroot -p${RootPass} -e "CREATE USER '${MDB_User}'@'%' IDENTIFIED BY '${DB_Pass}';"
  #sudo mysql -uroot -p${RootPass} -e "GRANT ALL PRIVILEGES ON ${DB_Name}.* TO '${MDB_User}'@'%';"
  #sudo mysql -uroot -p${RootPass} -e "FLUSH PRIVILEGES;"
  

  sudo systemctl enable firewalld
  sudo systemctl start firewalld
  sudo firewall-cmd --permanent --zone=public --add-service=http
  sudo firewall-cmd --permanent --zone=public --add-service=https
  sudo firewall-cmd --add-port=3306/tcp 
  sudo firewall-cmd --permanent --add-port=3306/tcp
