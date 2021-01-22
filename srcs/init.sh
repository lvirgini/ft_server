#!/bin/sh

if [ "$AUTOINDEX" = "off" ]; then
	sed -i "s/autoindex on/autoindex off/g" etc/nginx/sites-available/wordpress.conf
fi

service php7.3-fpm start
service php7.3-fpm status
service nginx start
service mysql start

# CONFIGURATION MYSQL MARIADB : 							
mysql -e 	"CREATE DATABASE wordpress;
			GRANT ALL ON wordpress.* TO 'wp_admin'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;
			FLUSH PRIVILEGES;"
echo		"configuration mysql DONE"

# afin que le container ne se ferme pas juste apres le run : 
/bin/bash