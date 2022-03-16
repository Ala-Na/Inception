# Mainly inspired and simplified from https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/
# Adjustments from https://www.novixys.com/blog/nginx-inside-docker-ubuntu-howto/
# and https://codingwithmanny.medium.com/configure-self-signed-ssl-for-nginx-docker-from-a-scratch-7c2bcd5478c6


FROM debian:buster

# prevent package from prompting interactive input
ENV DEBIAN_FRONTEND=noninteractive

# make defaut root folder of web server
# TODO maybe delete ?
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

## creation of new group and user nginx to avoid rootless container
RUN groupadd -r nginx && useradd -r -g nginx nginx;
	chown -R nginx /var/www/html

# install of nginx with -y option
# openssl need to be installed to to use TSL1.2 or TSL1.3 protocol
RUN apt-get -y install curl gnupg1 ca-certificates lsb-release debian-archive-keyring \
	&& apt-get -y update \
	&& apt-get -y upgrade \
	&& apt-get -y install nginx openssl

# remove unneeded files
# TODO maybe delete ?
RUN rm -f /etc/nginx/fastcgi.conf /etc/nginx/fastcgi_params \
	&& rm -f /etc/nginx/snippets/fastcgi_php.conf

# copy https files from build to correct image path
# TODO maybe delete ?
COPY nginx/ssl /etc/nginx/ssl
COPY nginx/snippets /etc/nginx/snippets
COPY nginx/sites-available /etc/nginx/sites-available

# For option explainations : https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04
# and https://codingwithmanny.medium.com/configure-self-signed-ssl-for-nginx-docker-from-a-scratch-7c2bcd5478c6
# TODO generate openssl certificate and key, modify paths
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /path/for/key -out /path/for/certificate \
	-subj "/C=FR/ST=Ile-de-France/L=Paris/O=42-Paris/OU=Inception project/CN=anadege"


# Container must listen on 443 port according to subjects
# It can be overide by docker run -p option
EXPOSE 443

# launch nginx in foreground and not background, advised for docker containers
# CMD could be use here but ENTRYPOINT is better for non additional set of argument
# as it can't be overlooked.
ENTRYPOINT ["nginx", "-g", "daemon off;"]
