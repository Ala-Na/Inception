## Mainly inspired and simplified from https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/
## Adjustments from https://www.novixys.com/blog/nginx-inside-docker-ubuntu-howto/
## and https://wiki.alpinelinux.org/wiki/Nginx
## and https://codingwithmanny.medium.com/configure-self-signed-ssl-for-nginx-docker-from-a-scratch-7c2bcd5478c6
## and http://www.w3big.com/fr/docker/docker-install-nginx.html
## and https://faun.pub/setting-up-ssl-certificates-for-nginx-in-docker-environ-e7eec5ebb418
## For openssl explanations : https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04

FROM alpine:3.14

RUN set -e; \
	mkdir -p /var/www/html

RUN adduser -D -g 'nginx' nginx; \
	chown -R nginx:nginx /var/www/html


# install of nginx with -y option
# openssl need to be installed to to use TSL1.2 or TSL1.3 protocol
RUN apk update \
	&& apk upgrade \
	&& apk add nginx openssl

# create directory for future openssl key and certificate, and generate them
RUN mkdir /etc/nginx/certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/certs/anadege.42.fr.key \
	-out /etc/nginx/certs/anadege.42.fr.crt \
	-subj "/C=FR/ST=Ile-de-France/L=Paris/O=42-Paris/OU=Inception project/CN=anadege"

# copy conf file to correct directory which is http.d and not conf.d for alpine 3.14
# source : https://alpinelinux.org/posts/Alpine-3.14.0-released.html
COPY /conf/nginx.conf /etc/nginx/http.d/nginx.conf

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

# container must listen on 443 port according to subjects
# It can be overide by docker run -p option
EXPOSE 443

# launch nginx in foreground and not background, advised for docker containers
CMD ["nginx", "-g", "daemon off;"]
