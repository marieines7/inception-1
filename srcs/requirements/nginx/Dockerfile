FROM	debian:buster

# Mise a jour du gestionnaire de paquet
RUN		apt-get update && apt-get upgrade -y

# Installation de nginx et openssl
#RUN		apt-get install  --no-cache --quiet --update nginx curl php8 php8-ctype
RUN		apt-get install -y nginx curl openssl bash \
		nginx vim procps openssl net-tools dumb-init
		#php7 php-gd php-xml

#RUN		apk add --no-cache --quiet --update openssl

# Creation du dossier qui va recueillir le certificat et la cle (pour HTTPS)
RUN		mkdir -p /etc/nginx/ssl

RUN		mkdir -p /var/run

# Generation des certificats et cles au nom du student
# RUN 	openssl req -x509 -nodes \
# 	-out /etc/nginx/ssl/malatini.42.fr.crt \	
# 	-keyout /etc/nginx/ssl/malatini.42.fr.key \
# 	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=malatini.42.fr/UID=malatini"

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/malatini.key -out /etc/nginx/ssl/malatini.crt \
	-subj "/C=FR/ST=Paris/L=Paris/O=42Paris/OU=malatini.42.fr/CN=malatini.42.fr"

# Creation du dossier qui va contenir les fichiers de configurations de nginx pour le serveur
RUN 	mkdir -p /var/run/nginx

#RUN		chmod 777 /etc/php7/

# Copie sur le container du fichier de configuration pour servir la page qu'on souhaite
#COPY	config/nginx.conf /etc/nginx/conf.d/default.conf
COPY	config/host /etc/nginx/
COPY config/nginx.conf /etc/nginx/default.conf

# Exposition du seul port autorise par le sujet
EXPOSE	443

COPY ./scripts/entrypoint.sh ./

# Lancement de nginx en premier plan et non en background (les logs seront dans /var/log/nginx) 
# pour que le container ne se stop pas
#ENTRYPOINT	[ "bash", "./entrypoint.sh" ]

ENTRYPOINT ["nginx", "-g", "daemon off;"]
