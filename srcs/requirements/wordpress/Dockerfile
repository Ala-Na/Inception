# https://wiki.alpinelinux.org/wiki/WordPress
# https://howto.wared.fr/installation-wordpress-ubuntu-nginx/
# https://www.cyberciti.biz/faq/how-to-install-php-7-fpm-on-alpine-linux/
# https://github.com/docker-library/wordpress/blob/master/Dockerfile.template
# https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose
# https://make.wordpress.org/cli/handbook/guides/installing/

FROM alpine:3.14

RUN apk update \
	&& apk upgrade \
	# installation of php submodules needed and other needed modules
	&& apk add curl php7-fpm php7-cli php7-curl php7-gd php7-intl php7-zlib php7-mysqli; \
	# installation of wordpress
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/bin/wp

# create a user for wordpress
RUN adduser wordpress \
	&& addgroup wordpress \
	&& chown -R wordpress:wordpress /var/www/wordpress \
	&& chmod -R o-rwx /var/www/wordpress

WORKDIR /var/www/wordpress
