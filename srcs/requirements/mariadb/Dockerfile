# Depuis l'image la plus legere
#FROM	debian:buster
FROM debian:buster

# Mise a jour du gestionnaire de paquet, bonne pratique
# RUN		apk update
# Mise a jour du gestionnaire de paquet
RUN		apt-get update && apt-get upgrade -y

# Installation de mariadb et mariadb client
# RUN		apk add --no-cache --quiet --update mariadb mariadb-client vim
RUN		apt-get install -y mariadb-server mariadb-client vim bash gettext-base

# Creation du dossier pour le daemon
RUN 	mkdir -p /var/lib/mysqld /run/mysqld

# Execution du script de creation de la base de donnees
COPY	./config/create_db.sql /tmp/create_db.sql

# Copie du script entrypoint sur le container
COPY	./scripts/entrypoint.sh ./

COPY 	./config/mariadb-server.cnf /etc/my.cnf.d/

RUN 	chmod +x ./entrypoint.sh

# Installation de la base de donnee effective et authentification
#RUN		mariadb-install-db --datadir=/var/lib/mysql \
#			--auth-root-authentication-method=normal

#RUN mysql-secure-installation -y

EXPOSE 3306

COPY ./config/mariadb-server.cnf /tmp
RUN mv ./tmp/mariadb-server.cnf /etc/mysql/mariadb-server.cnf && chmod 0755 /etc/mysql/mariadb-server.cnf 

# Le user mysql doit etre le owner des dossiers relatifs a mysql
RUN		chown -R mysql:mysql /var/lib/mysql 

# Attribution des droits pour le daemon
RUN 	chown -R mysql:mysql /run/mysqld

ENTRYPOINT [ "bash", "entrypoint.sh" ]