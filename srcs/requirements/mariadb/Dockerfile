FROM debian:buster

# prevent package from prompting interactive input
ENV DEBIAN_FRONTEND=noninteractive

# install of mariadb with -y option
RUN apt-get -y update \
	&& apt-get -y upgrade \
	&& apt-get -y install vim mariadb-server mariadb-client

# create non root user to avoid rootless container
# https://sysdig.com/blog/dockerfile-best-practices/
#RUN adduser -D anadege \
#	&& chown -R anadege 

# Container default port must be exposed
# No effect if port is not exposed at container creation
EXPOSE 3306

HEALTHCHECK --start-period=5m \
	CMD mariadb -e 'SELECT @@datadir;' || exit 1

CMD ["mysqld_safe"]
