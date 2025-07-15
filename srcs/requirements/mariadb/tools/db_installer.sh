#!/bin/sh

#setup necessary perms for mariaDB data directory
chown -R mysql:mysql /var/lib/mysql

#configre mariaDB ports
#sed -i "s/REPLACE_MYSQL_PORT/$DB_PORT/g" /etc/mysql/my.cnf

#initialize MariaDB (using mySQL cmd cause they are the same ffs)
mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

#start MDB in the background
/usr/bin/mariadbd-safe --datadir=/var/lib/mysql &

#wait until the MDB server is available
while ! /usr/bin/mariadb-admin ping --silent; do
	sleep 1
done

#cleaning up default setups
mariadb -u root -e "DROP DATABASE IF EXISTS test;"
mariadb -u root -e "DELETE FROM mysql.user WHERE User='';"
mariadb -u root -e "DELETE FROM mysql.db WHERE Db='test';"

#create our own new setup
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;"
mariadb -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
mariadb -u root -e "FLUSH PRIVILEGES;"

#shutdown MDB in the background
mariadb-admin shutdown

#start MDB in the foreground (so container does not auto shutdown)
/usr/bin/mariadbd-safe --datadir=/var/lib/mysql
