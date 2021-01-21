# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lvirgini <lvirgini@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/24 13:34:24 by lvirgini          #+#    #+#              #
#    Updated: 2021/01/21 17:14:02 by lvirgini         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

# -----------------------------
#	Installation des packages
# -----------------------------

RUN	apt-get -y update && apt-get -y upgrade
RUN apt-get -y install wget nginx-full mariadb-server mariadb-client \
	php-fpm php-mysql php-mbstring php-zip php-gd php-curl php-intl  \
	php-soap php-xml php-xmlrpc

# -----------------
#	Configuration
# -----------------

# NGINX et SSL:

RUN rm /etc/nginx/sites-enabled/default 			 && \
	rm -rf var/www/html								 && \
	openssl req -x509 -nodes -days 1 -newkey rsa:2048 	\
	-keyout etc/ssl/private/ft_server_key.pem			\
	-out etc/ssl/certs/ft_server_cert.pem 				\
	-subj "/C=FR/ST=FRANCE/L=PARIS/O=FTSERVER/CN=127.0.0.1" && \
	openssl dhparam -out /etc/nginx/dhparam.pem 2048

# WORDPRESS

COPY	srcs/wordpress.conf /etc/nginx/sites-available
RUN		mkdir var/www/localhost								&& \
		wget http://fr.wordpress.org/latest-fr_FR.tar.gz 	&& \
		tar -xzf latest-fr_FR.tar.gz -C /var/www/localhost/	&& \
		rm latest-fr_FR.tar.gz 								&& \
		chown -R $USER:$USER /var/www/localhost/wordpress 	&& \
		ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/
COPY    srcs/wp-config.php /var/www/localhost/wordpress


# PHP MY ADMIN :

RUN 	mkdir var/www/localhost/phpmyadmin && \
		wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-all-languages.tar.gz   && \
		tar -xzf phpMyAdmin-4.9.5-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin && \
		rm phpMyAdmin-4.9.5-all-languages.tar.gz
COPY  	srcs/config.inc.php /var/www/localhost/phpmyadmin


# INITIALISATION DU CONTAINER :

COPY 	srcs/init.sh /usr/bin/init.sh

ENV 	AUTOINDEX=on

EXPOSE 	80 443

ENTRYPOINT ["usr/bin/init.sh"]

# permet de laisser le docker tourner en arriere plan (option -d)
CMD ["bin/bash"]
