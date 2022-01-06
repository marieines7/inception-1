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

cat .setup 2> /dev/null
if [ $? -ne 0 ]; then
	usr/bin/mysqld_safe --datadir=/var/lib/mysql &

	# Apply config
	sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0\nport=3306|g" /etc/my.cnf.d/mariadb-server.cnf
	
	# Config MariaDB with default bases
	if ! mysqladmin --wait=30 ping; then
		printf "Unable to reach mariadb\n"
		exit 1
	fi

	eval "echo \"$(cat /tmp/create_db.sql)\"" | mariadb
	# pkill mariadb
	touch .setup
fi

usr/bin/mysqld_safe --datadir=/var/lib/mysql