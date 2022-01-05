# Utilisation de l image la plus legere
FROM	debian:buster

# Mise a jour du gestionnaire de paquet + telechargements des outils
# php7-iconv est necessaire pour acceder a la partie wp-admin
# RUN		apk update
RUN		apt-get update && apt-get upgrade -y
# RUN		apk add --no-cache --quiet --update curl bash vim
# RUN		apk add --no-cache --quiet --update mariadb-client
# RUN		apk add --no-cache --quiet --update php7 php7-phar \
# 			php7-json php7-curl php7-fpm php7-mysqli php7-iconv

RUN		apt-get install -y curl bash vim wget
RUN		apt-get install -y mariadb-client
RUN		apt-get install -y php7.3 php-mysql php-fpm php-mysqli php-curl \
    php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

# On cree le dossier "standard"
RUN		mkdir -p /var/www/wordpress 

# Telecharger de la wordpress cli + ajout des droits d execution puisque c est une commande
RUN		curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
			--output /usr/bin/wp

#  RUN     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# On ajoute les droits d execution sur la command wp cli
RUN		chmod +x ./usr/bin/wp 
#RUN 	chmod 777 wp-cli.phar
# RUN  	mv wp-cli.phar /usr/local/bin/wp

# https://www.linode.com/docs/guides/how-to-install-wordpress-using-wp-cli-on-debian-10/
#RUN 	cd ~ wget https://github.com/wp-cli/wp-cli/raw/master/utils/wp-completion.bash

#RUN 	echo "source /home/$USER/wp-completion.bash" >> .bashrc

#RUN		touch .bashrc

#RUN     ln -sf /bin/bash /bin/sh
#RUN     source ~/.bashrc

#RUN     /usr/sbin/useradd -m -d /home/WPUSER/ -s /bin/bash WPUSER 
#RUN     echo -e "password\npassword" | passwd WPUSER
#RUN     chmod 700 /home/WPUSER/
# Telechargement de wordpress via la wp cli
#RUN		su - WPUSER 

#RUN     wp core download 
#--path=/var/www/wordpress
# --version=5.8.1

# Modification du workdir
WORKDIR /var/www/wordpress

# On copie le fichier de config pour que ca puisse marcher sur le container
COPY	config/wp-config /config/wp-config

# On copie le script entrypoint 
COPY	./scripts/entrypoint.sh /tmp/entrypoint.sh

# Ajout des droits d execution sur le script entrypoint
RUN		chmod +x /tmp/entrypoint.sh

#On passe par un entrypoint pour eviter les hacky path
ENTRYPOINT ["bash", "/tmp/entrypoint.sh"]