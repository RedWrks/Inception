#!/bin/sh

timeout=10
while ! mariadb -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -e ";" ; do
	echo "[INFO] Waiting for database connection..."
	sleep 1
	timeout=$(($timeout - 1))
	if [ $timeout -eq 0 ]; then
		echo "[ERROR] Timeout while waiting for database connection."
		exit 1
	fi
done
#DL l'installer
curl -O -s https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

if [ ! -f /var/www/html/wp-config.php ]; then
	php83 -d memory_limit=256M ./wp-cli.phar core download --version=6.7.2 --allow-root
	echo "[INFO] Installing Wordpress using wp-cli..."
	#configuring 
	php83 -d memory_limit=256M ./wp-cli.phar config create --dbname=$WP_DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_PASSWORD \
		--dbhost=$DB_HOST \
		--dbcharset="utf8" \
		--dbprefix="wp_" \
		--allow-root
	#admin user
	php83 -d memory_limit=256M ./wp-cli.phar core install --allow-root \
		--path='/var/www/html/' \
		--url=$WP_URL \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--skip-email
	#additional user
	php83 -d memory_limit=256M ./wp-cli.phar user create --allow-root \
		--path='/var/www/html/' \
		$WP_CONTRIB_USER $WP_CONTRIB_EMAIL \
		--user_pass=$WP_CONTRIB_PASSWORD \
		--role=contributor
fi

echo "[INFO] Starting php-fpm..."
php-fpm83 -F -R
