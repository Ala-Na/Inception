#!/bin/sh

# set wordpress
	#--dbuser=$WORDPRESS_DB_USER \
# https://make.wordpress.org/cli/handbook/how-to-install/
wp config create --dbname=test --dbuser=test 
	#--dbpass=$WORDPRESS_DATABASE_PASSWORD --dbhost=$WORDPRESS_DB_HOST \
	#--dbcharset=$WORDPRESS_DB_CHARSET \
	#--dbcollate=$WORDPRESS_DB_COLLATE --allow-root
wp core install --url="anadege.42.fr" --title="INCEPTION" --admin_user="nimda" \
	--admin_password=apsswdfornimda --admin_email=anadege@student.42.fr 


php-fpm7 --nodaemonize
