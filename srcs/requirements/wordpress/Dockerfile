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
	&& apk add bash curl php-json php-phar php-fpm php-cli php-curl php-gd php-intl php-zlib php-mysqli php-iconv mariadb-client; \
	# installation of wordpress
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --silent\
	&& chmod -R +x wp-cli.phar 



# create a user for wordpress
RUN adduser -Dsg wordpress wordpress 
	#&& mkdir -p /var/www/wordpress \
	#&& chown -R wordpress:wordpress /var/www/wordpress
	
RUN mv wp-cli.phar /usr/bin/wp

# Copy needed configuration files
COPY conf/php-fpm.conf /etc/php7/php-fpm.conf
COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

WORKDIR /var/www/wordpress/wordpress

#RUN wp core download
COPY conf/entrypoint.sh /tmp/entrypoint.sh

EXPOSE 9000

# go to entrypoint to wait for mariadb
ENTRYPOINT [ "sh", "/tmp/entrypoint.sh"]
