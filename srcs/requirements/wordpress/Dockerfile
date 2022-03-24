# Real image : https://github.com/docker-library/wordpress/blob/master/Dockerfile.template
# Alpine fpm version : https://github.com/docker-library/wordpress/blob/master/beta/php7.4/fpm-alpine/Dockerfile
# https://wiki.alpinelinux.org/wiki/WordPress
# https://howto.wared.fr/installation-wordpress-ubuntu-nginx/
# https://www.cyberciti.biz/faq/how-to-install-php-7-fpm-on-alpine-linux/
# https://github.com/docker-library/wordpress/blob/master/Dockerfile.template
# https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose
# https://make.wordpress.org/cli/handbook/guides/installing/
# https://blog.linoproject.net/the-making-of-wordpress-docker-image/

FROM alpine:3.14

RUN set -e; \
	apk update \
	&& apk upgrade \
	# installation of php submodules needed and other needed modules
	&& apk add bash curl php-json php-phar php-fpm php-cli php-curl php-gd php-intl php-zlib php-mysqli; \
	# installation of wordpress
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --silent\
	&& chmod +x wp-cli.phar 
	
RUN mv wp-cli.phar /usr/bin/wp


## create a user for wordpress
#RUN adduser -Dg www-data wordpress\
#	&& mkdir -p /var/www/wordpress \
#	&& chown -R wordpress:www-data /var/www/wordpress \
#	&& chmod -R o-rwx /var/www/wordpress

RUN wp core download

# Copy needed configuration file
# (www.conf to give instructions to set www poll and wp-config to configurate wp)
COPY /conf/www.conf /etc/php7/php-fpm.d/
COPY conf/wp-config-docker.php /conf/wp-config.php

WORKDIR /var/www/wordpress

COPY conf/entrypoint.sh /tmp/entrypoint.sh

EXPOSE 9000

# go to entrypoint to wait for mariadb
ENTRYPOINT [ "sh", "/tmp/entrypoint.sh"]
