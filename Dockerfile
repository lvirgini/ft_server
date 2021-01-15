# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lvirgini <lvirgini@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/24 13:34:24 by lvirgini          #+#    #+#              #
#    Updated: 2021/01/13 13:27:54 by lvirgini         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

# sur linux, utilisation de bash. par defaut: ["/bin/sh", "-c"] 
#SHELL ["/bin/bash", "-c"] 

# -----------------------------
#	Installation des packages	  RETIRER VIM
# -----------------------------

RUN		apt-get -y update && apt-get -y upgrade 
RUN 	apt-get -y install wget nginx-full mariadb-server mariadb-client \
		php-fpm php-mysql php-mbstring php-zip php-gd php-curl php-intl  \
		php-soap php-xml php-xmlrpc vim

# -----------------
#	Configuration	
# -----------------

# NGINX :
 
RUN cp /etc/ssl/openssl.cnf /etc/nginx/openssl.cnf && 	\
	openssl req -x509 -nodes -days 1 -newkey rsa:2048 	\
	-config /etc/ssl/openssl.cnf						\
	-keyout etc/ssl/private/ft_server.key 				\
	-out etc/ssl/certs/ft_server.csr 					\
	-subj "/C=FR/ST=FRANCE/L=PARIS/O=FTSERVER/CN=localhost" && 	\
	openssl dhparam -out /etc/nginx/dhparam.pem 4096

# WORDPRESS

#COPY	srcs/wordpress.conf /etc/nginx/sites-available
RUN 	wget http://fr.wordpress.org/latest-fr_FR.tar.gz 	&& \
		tar -xzf latest-fr_FR.tar.gz -C /var/www/			&& \
		rm latest-fr_FR.tar.gz 								&& \
		chown -R $USER:$USER /var/www/wordpress 		
#		ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled
#COPY    srcs/wp-config.php /var/www/wordpress


# PHP MY ADMIN : 


# NGINX :
 
RUN cp /etc/ssl/openssl.cnf /etc/nginx/openssl.cnf && 	\
	openssl req -x509 -nodes -days 1 -newkey rsa:2048 	\
	-config /etc/ssl/openssl.cnf						\
	-keyout etc/ssl/private/ft_server.key 				\
	-out etc/ssl/certs/ft_server.csr 					\
	-subj "/C=FR/ST=FRANCE/L=PARIS/O=FTSERVER/CN=localhost"


COPY 	srcs/start.sh /usr/bin/start.sh

EXPOSE 80:80

ENTRYPOINT ["usr/bin/start.sh"]

#CMD ["bin/sh"] ne sert a rien finallement
