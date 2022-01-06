# cat .setup 2> /dev/null
# if [ $? -ne 0 ]; then
# 	# https://dev.mysql.com/doc/refman/8.0/en/mysqld-safe.html
# 	# Le & va etre utilise pour effectuer une "modification sur le serveur MySQL" - mysql driver avec des options
# 	usr/bin/mysqld_safe --datadir=/var/lib/mysql &

# 	# Il est necessaire d'attendre que la base de donnee soit bien accessible, mysql lance
# 	while ! mysqladmin ping -h "$MARIADB_HOST" --silent; do
#     	sleep 1
# 	done

# 	eval "echo \"$(cat /tmp/create_db.sql)\"" | mariadb
# 	touch .setup
# fi
# # Lancement du serveur mysql de facon la plus securisee sur Uinix
# usr/bin/mysqld_safe --datadir=/var/lib/mysql

# Une fois dans le container, on pourra
# mysql -u root -p (puis rentrer root_pwd)
# SHOW DATABASES;
# use 'wordpress';
# SHOW TABLES;
# SELECT wp_users.display_name FROM wp_users;
# SELECT *  FROM wp_users;

#mariadb-install-db --datadir=/var/lib/mysql \
#			--auth-root-authentication-method=normal

# cat .setup 2> /dev/null
# if [ $? -ne 0 ]; then
# 	usr/bin/mysqld_safe --skip-grant-tables &

# 	sleep 5
# 	#--datadir=/var/lib/mysql
# 	service mysql stop
# 	mysqld -umysqld &

# 	sleep 5
# 	# Apply config
# 	sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
# 	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0\nport=3306|g" /etc/my.cnf.d/mariadb-server.cnf
	
# 	# Config MariaDB with default bases
# 	# if ! mysqladmin --wait=30 ping; then
# 	# 	echo "Unable to reach mariadb\n"
# 	# 	exit 1
# 	# fi

# 	eval "echo \"$(cat /tmp/create_db.sql)\"" | mariadb
# 	# pkill mariadb
# 	touch .setup
# fi
# service mysql stop

# sleep 5

# #usr/bin/mysqld_safe --datadir=/var/lib/mysql
# exec /usr/sbin/mysqld

#!/bin/bash

mysqld_safe --skip-grant-tables &

sleep 5

echo "SHOW DATABASES" | mysql -u root -p'$MARIADB_ROOT_PWD'
dbreuse=$(echo "SHOW DATABASES" | mysql -u root -p'$MARIADB_ROOT_PWD'| grep $MARIADB_DB | wc -l)

echo "Do we alread have a $MARIADB_DB db ?"
if [ $dbreuse == 1 ]; then
echo "Yes"

echo "**********SHOW DATABASES*********"
echo "SELECT host, user, password FROM mysql.user;" | mysql -u root -p'$MARIADB_ROOT_PWD'
echo "*********************************"
echo "Check that the 'root' password is not empty"

else
echo "Non, on en cree une"
service mysql stop
mysqld -umysql &
sleep 5
echo "CREATE DATABASE IF NOT EXISTS $MARIADB_DB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci" | mysql
echo "CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PWD'" | mysql
echo "GRANT ALL ON $MARIADB_DB .* TO '$MARIADB_USER'@'%'" | mysql
echo "FLUSH PRIVILEGES;" | mysql
echo "When setting it up, change the root password"
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_ROOT_PWD');" | mysql -u root
fi

service mysql stop

sleep 5

echo "We launch the MYSQL DAEMON now"
exec /usr/sbin/mysqld