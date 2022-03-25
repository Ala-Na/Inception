#!/bin/sh

while ! mariadb  &>/dev/null; do
    sleep 3
	echo sleep
done

# set wordpress
	#--dbuser=$WORDPRESS_DB_USER \
# https://make.wordpress.org/cli/handbook/how-to-install/
wp core download

wp core install --url="anadege.42.fr" --title="INCEPTION" --admin_user="nimda" \
	--admin_password=apsswdfornimda --admin_email=anadege@student.42.fr 

wp user create wordpress anadege@student.42.fr --role=author --user_pass='mdp' --allow-root

php-fpm7 --nodaemonize
