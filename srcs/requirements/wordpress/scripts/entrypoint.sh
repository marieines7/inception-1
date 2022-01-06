# #On va modifier le fichier www.conf pour que ca fonctionne en local comme demande
# target="/etc/php7/php-fpm.d/www.conf"

# # On aurait aussi pu reprendre le fichier dans notre dossier config plutot que de fonctionner comme ca
# grep -E "listen = 127.0.0.1" $target > /dev/null 2>&1
# if [ $? -eq 0 ]; then
# 	sed -i "s|.*listen = 127.0.0.1.*|listen = 9000|g" $target
# 	echo "env[MARIADB_HOST] = \$MARIADB_HOST" >> $target
# 	echo "env[MARIADB_USER] = \$MARIADB_USER" >> $target
# 	echo "env[MARIADB_PWD] = \$MARIADB_PWD" >> $target
# 	echo "env[MARIADB_DB] = \$MARIADB_DB" >> $target
# fi

# # Attention il y a un vrai pb avec le user sur ubuntu
# 	#sudo -u USER wp core download --path=/var/www/wordpress

# # Va permettre d'eviter de lancer ce script php systematiquement ?
# if [ ! -f "wp-config.php" ]; then
# 	cp /config/wp-config ./wp-config.php

# 	sleep 5

# 	if ! mysqladmin -h $MARIADB_HOST -u $MARIADB_USER \
# 		--password=$MARIADB_PWD --wait=60 ping > /dev/null; then
# 		echo "MySQL is not available.\n"
# 		exit 1
# 	fi

# 	# Configuration du site wordpress
# 	sudo -u USER wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" \
#     	--admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email

# 	#wp plugin install redis-cache --activate
# 	sudo -u USER wp plugin update --all

# 	# Installation de notre theme et "activation"
# 	sudo -u USER wp theme install twentysixteen --activate

# 	sudo -u USER wp user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PWD

# 	# Creation d'un article pour l'example
# 	sudo -u USER wp post generate --count=5 --post_title="malatini"
# fi

echo "On rentre dans le .sh"

cd
#Remplacera les valeurs fournies par le .env dans le wp-config
#On teste bien a chaque fois l'existence du fichier afin de pouvoir gerer les reboots
[ -f /tmp/wp-config.php ] && sed -i -e "s|MARIADB_DB|'$MARIADB_DB'|g" /tmp/wp-config.php
[ -f /tmp/wp-config.php ] && sed -i -e "s|MARIADB_USER|'$MARIADB_USER'|g" /tmp/wp-config.php
[ -f /tmp/wp-config.php ] && sed -i -e "s|MARIADB_PWD|'$MARIADB_PWD'|g" /tmp/wp-config.php
[ -f /tmp/wp-config.php ] && sed -i -e "s|MARIADB_HOST|'$MARIADB_HOST'|g" /tmp/wp-config.php

sed -i -e "s|;daemonize = yes|daemonize = no|g" /etc/php/7.3/fpm/php-fpm.conf

if [ ! -d "/var/www/wordpress" ]; then
echo "AUCUN SITE TROUVE"
echo "Installation d'un wordpress vierge"
mv /wordpress /var/www/
else
echo "Un site est pre-configure"
rm -rf /wordpress
fi

[ -f /tmp/wp-config.php ] && mv /tmp/wp-config.php /var/www/wordpress/wp-config.php


chmod -R 755 /var/www/
mkdir -p /run/php/

#echo "On rentre dans le .sh"

# sed -i -e "s|;daemonize = yes|daemonize = no|g" /etc/php/7.3/fpm/php-fpm.conf
chmod -R 755 /var/www/
mkdir -p /run/php/

exec /usr/sbin/php-fpm7.3