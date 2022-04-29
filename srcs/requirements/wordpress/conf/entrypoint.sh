#!/bin/sh

# Wait for mariadb to be up and running
sleep 1

# Check that mariadb is up and running
# https://stackoverflow.com/questions/30888109/shell-script-to-check-if-mysql-is-up-or-down
# http://underpop.online.fr/m/mysql/manual/mysql-programs-mysqlWORDPRESS_ADMIN.html
# https://stackoverflow.com/questions/25503412/how-do-i-know-when-my-docker-mysql-container-is-up-and-mysql-is-ready-for-taking
while ! mysqladmin ping -h $WORDPRESS_DB_NAME -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PWD &>/dev/null; do
	echo "Wordpress waiting for mysql/mariadb..."
    sleep 1
done

# Set wordpress
# https://make.wordpress.org/cli/handbook/how-to-install/

if [ ! -f "wp-config.php" ]; then #wp-config.php is set at first call of config create
	wp core download --allow-root
	wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PWD --dbhost=$WORDPRESS_DB_NAME --dbcharset=$WORDPRESS_DB_CHARSET --allow-root
	wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN \
		--admin_password=$WORDPRESS_ADMIN_PWD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email
	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --user_pass=$WORDPRESS_USER_PWD --role=author --allow-root
fi

echo "You can now access Wordpress"

php-fpm7 --nodaemonize
