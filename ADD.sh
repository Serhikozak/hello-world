# Install App >
curl https://download.moodle.org/download.php/direct/stable36/moodle-latest-36.tgz -o moodle-latest-36.tgz -s
sudo tar -xvzf moodle-latest-36.tgz -C /var/www/html/
#
sudo /usr/bin/php /var/www/html/moodle/admin/cli/install.php \
--lang=uk \
--chmod=2770 \
--wwwroot=http://localhost:8081/moodle \
--dataroot=/var/moodledata \
--dbtype=mariadb \
--dbhost=localhost \
--dbport=3306 \
--dbname=${DBNAME} \
--dbuser=${DBUSER} \
--dbpass=${DBPASS} \
--fullname=Moodle \
--shortname=ymd \
--summary=Moodle01 \
--adminuser=${MOODLEUSER} \
--adminpass=${MOODLEPASS} \
--non-interactive \
--agree-license


sudo chmod o+r /var/www/html/moodle/config.php
###sudo chown -R apache:apache /var/www/html/
sudo chcon -R -t httpd_sys_rw_content_t /var/moodledata
sudo chown -R apache:apache /var/moodledata
sudo chown -R apache:apache /var/www/
# <
# configuring Apache vhost>
sudo systemctl stop httpd
cd /etc/httpd/conf.d/
sudo touch moodle.conf
cat <<EOF | sudo tee -a /etc/httpd/conf.d/moodle.conf
<VirtualHost *:8081>
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