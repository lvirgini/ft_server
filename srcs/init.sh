#!/bin/sh

service php7.3-fpm start
service php7.3-fpm status
service nginx start
service mysql start


# CONFIGURATION MYSQL MARIADB : 							
mysql -e 	"CREATE DATABASE wordpress;
			GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;
			FLUSH PRIVILEGES;"
echo		"configuration mysql DONE"

openssl verify etc/ssl/certs/ft_server_cert.pem

# afin que le container ne se ferme pas juste apres le run : 
/bin/bash