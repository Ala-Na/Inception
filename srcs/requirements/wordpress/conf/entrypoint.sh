#!/bin/sh

echo "here"

#while ! mariadb -h$MYSQL_HOST -u$WP_DATABASE_USR -p$WP_DATABASE_PWD $WP_DATABASE_NAME &>/dev/null; do
#    sleep 3
#	echo 'sleep'
#done

echo "go to php"

php-fpm7 --nodaemonize
