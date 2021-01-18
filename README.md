
# BUT DU PROJET FT_SERVER
##	Apprentissage :
- Découverte de l'administration systeme
- Automatisation des taches avec des scripts
- installation et configuration d'un server web
- Utilisation de Docker
- Dockerfiles
- configuration des services Wordpress, PhpmyAdmin et une base de donnée MySql

##	Consignes : 
- Vous devrez, dans un seul container Docker, mettre en place un serveur web avec
Nginx. Le container devra tourner avec Debian Buster.
- Votre serveur devra être capable de faire tourner plusieurs services en même temps.
Les services seront un Wordpress à installer par vous même, ainsi que Phpmyadmin
et MySQL. Vous devrez vous assurer que votre base de donnée SQL fonctionne
avec le wordpress et phpmyadmin.
- Votre serveur devra pouvoir, quand c’est possible, utiliser le protocole SSL.
- Vous devrez vous assurer que, selon l’url tapé, votre server redirige vers le bon
site.
- Vous devrez aussi vous assurer que votre serveur tourne avec un index automatique
qui doit pouvoir être désactivable.

## Précision Amélie (correction): 
Précisions sur le sujet : 

- Le containeur doit tout télécharger, installer, configurer avec la commande docker build. Aucune manipulation ne doit avoir lieu après cette commande.
- Il doit être possible pour Wordpress de :
	- Envoyer des mails.
	- Uploader des fichiers.
	- Uploader / installer des thèmes.
	- Créer des posts.
	- Installer des modules
	Il faut aussi vérifier d'avoir les bonnes extensions de PHP.
- Il doit être possible pour PHPMyAdmin de :
	- Créer / télécharger une base de données.
	- Créer / supprimer des utilisateurs.
	- Uploader des tables.
- Il faut faire attention d'avoir toutes les permissions nécessaires dans le système.

#
# 	COMMANDES DOCKER

	Note : debconf et apt-utils -> ne pas en tenir compte.

##	construction du container :
	docker build -t ft_server .
				-t <nom> 	: tag pour retrouver facilement le container
				--no-cache 	: sans utiliser les images chaches
## Lancement du container :
	docker run -it <ft_server> bash 
	docker run  --rm -ti -d ft_server -p 80:80  
				--rm pour supprimer le docker apres le run fini
				-d detacher du terminal donne l'ID du container 
				-p <port de la machine> : <port virtuel> force l'ecoute du port
				-i intéractive mode permet d'acceder au STDIN
				-t active mode TTY permet d'acceder au STDOUT (terminal du container)

##	Gestion des containers :
Pour garder le container actif :

	- docker run -it <ft_server> bash 
	- CMD bin/bash et docker run -it //////////// nope
##
	docker ps 		: lister les containers en cours
	docker images 	: lister les images deja creees (cache)
	docker stop <id>: arrete le container id
	docker rm <id> 	: supprime le container id
	docker rmi <id> : supprime l'image id (c'est le cache des containers)

	->	docker stop $(docker ps -a -q)
	->	docker rm $(docker ps -a -q)
	->  docker rmi $(docker images -a -q) puis sudo service docker restart 

	docker exec -ti <id> bash : on rentre dans le docker en root et sur bash.
	
## Si probleme : 
supprimer toutes les images et containers avec les trois commandes plus haut ->	puis sudo service docker restart

#
# DOCKERFILE :

sur linux par defaut: ["/bin/sh", "-c"]
	
	SHELL ["/bin/bash", "-c"] 
	ADD /hote /dest	: /hote peut etre une URL
	COPY 			:est la meme chose mais interne
	if ADD .sh -> RUN chmode 755 /dest.sh
	EXPOSE: le docker ecoute le port indique
			if 80:80 : impose l'ecoute sur le port 80 de l'ordi ///////////////
			ce qui empeche de lancer deux fois le meme container
			un port ne peut etre utiliser que par un seul process

	CMD 	executé par default lors du run. (1 seule cmd CMD)
			Attention si docker run est lancé avec une instruction,
			CMD est tout simplement écrasé par l'instruction.
			ex: CMD "start.sh"  docker run ft_service bash 
	ENV =	variable environnement valable dans tout le container
	ENV = 	suivi d'une commande : la variable n'est valable que pour la commande.
	ENTRYPOINT : ["commandes ou chemin"] : point d'entrée.
	WORKDIR repertoire par default de travail a l'ouverture du bash du container

#
# INSTALATIONS

## Configuration LEMP : linux + nginx + mysql + php
- installation LEMP : https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04#step-3-%E2%80%93-installing-php-and-configuring-nginx-to-use-the-php-processor
- certificat SSL : https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-18-04#step-2-%E2%80%93-configuring-nginx-to-use-ssl

## Configuration Mysql via Mariadb : 							
 	mysql -e "" :	
	 	CREATE DATABASE <database_name>
		CREATE USER <nom> 	: creation utilisateur "nom"
		@"domaine" 			: uniquement sur le domaine "domaine"
		IDENTIFIED BY <mdp>	: identifie avec le mdp
		"GRANT ALL ON " <database> ".* TO <user_name> @ <domaine> WITH GRANT OPTION;"


## Configuration Wordpress : 
- installation : 
https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-on-ubuntu-18-04

- fichier wp-config : 
https://fr.wordpress.org/support/article/editing-wp-config-php/

- fichier wordpress.conf : 
