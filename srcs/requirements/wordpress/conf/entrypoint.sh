#!/bin/sh

# http://underpop.online.fr/m/mysql/manual/mysql-programs-mysqladmin.html
while ! mysqladmin ping -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PWD &>/dev/null; do
	echo "sleep"
    sleep 1
done

# set wordpress
	#--dbuser=$WORDPRESS_DB_USER \
# https://make.wordpress.org/cli/handbook/how-to-install/
#cp ./wp-config ./wp-config.php
wp core download

wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRSS_DB_PWD --dbhost=$MYSQL_DATABASE --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root

wp core install --url="anadege.42.fr" --title="INCEPTION" --admin_user="nimda" \
	--admin_password=apsswdfornimda --admin_email=anadege@student.42.fr 

wp user create wordpress anadege@student.42.fr --role=author --user_pass='mdp' --allow-root

php-fpm7 --nodaemonize



#if [ ! -f "wp-config.php" ]; then
#	echo "HERE"
#	cp ./wp-config ./wp-config.php

#	sleep 5;
#	if ! mysqladmin -h $MYSQL_DATABASE -u $MYSQL_USER \
#		--password=$MYSQL_PWD --wait=60 ping > /dev/null; then
#		echo "MySQL is not available.\n"
#		exit 1
#	fi
#	wp core download --allow-root
#	wp core install --url="anadege.42.fr" --title="INCEPTION" --admin_user="nimda" \
#		--admin_password=apsswdfornimda --admin_email=anadege@student.42.fr

#	wp user create $WP_USER $WP_DB_EMAIL --role=author --user_pass=$WP_USER_PWD

#fi


#echo "Wordpress started on :9000"
#php-fpm7 --nodaemonize

## TODO deete following
##!/bin/sh

## wait for mysql
#while ! mariadb -h$MYSQL_DATABASE -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PWD $WORDPRESS_DB_NAME &>/dev/null; do
#    sleep 3
#done

#if [ ! -f "/var/www/html/index.html" ]; then

#	wp core install --allow-root
#    wp core download --allow-root
#    wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PWD --dbhost=$MYSQL_DATABASE --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
#    wp core install --url=$DOMAIN_NAME/wordpress --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_DB_USER --admin_password=$WORDPRESS_DB_PWD --admin_email=$WORDPRESS_DB_EMAIL --skip-email --allow-root
#    wp user create $WORDPRESS_DB_USER $WORDPRESS_DB_EMAIL --role=author --user_pass=$WORDPRESS_DB_PWD --allow-root

#fi

##wp redis enable --allow-root

#echo "Wordpress started on :9000"
#/usr/sbin/php-fpm7 -F -R
