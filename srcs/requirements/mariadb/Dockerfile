# Mainly inspired from https://github.com/MariaDB/mariadb-docker 10.2

FROM debian:buster

# prevent package from prompting interactive input
ENV DEBIAN_FRONTEND=noninteractive

# creation of new group and user mysql to avoid rootless container
# https://sysdig.com/blog/dockerfile-best-practices/
RUN groupadd -r mysql && useradd -r -g mysql mysql

# install of mariadb with -y option and recreate files with correct permissions
RUN apt-get -y update \
	&& apt-get -y upgrade \
	&& apt-get -y install vim mariadb-server mariadb-client; \
	rm -rf /var/lib/apt/lists/*; \
	# note that /var/lib/mysql is the fault directory where MySQL by default will write its data files
	rm -rf /var/lib/mysql; \
	# note that /var/run/mysqld is the file used for socket and lock files
	mkdir -p /var/lib/mysql /var/run/mysqld; \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; \
	chmod 777 /var/run/mysqld; \
	# comment bind-address which can be problematic
	# bind address is set such as server only listen to localhost
	find /etc/mysql/ -name '*.cnf' -print0 \
	| xargs -0 grep -lZE '^(bind-address|log|user\s)' \
	| xargs -rt -0 sed -Ei 's/^(bind-address|log|user\s)/#&/'; \
	# correct issue of directories reading order
	if [ ! -L /etc/mysql/my.cnf ]; then sed -i -e '/includedir/i[mariadb]\nskip-host-cache\nskip-name-resolve\n' /etc/mysql/my.cnf; \
	else sed -i -e '/includedir/ {N;s/\(.*\)\n\(.*\)/[mariadbd]\nskip-host-cache\nskip-name-resolve\n\n\2\n\1/}' \
                /etc/mysql/mariadb.cnf; fi

COPY tools/secure_installation.sh /tmp/secure_installation.sh

# Container default port must be exposed
# No effect if port is not exposed at container creation
EXPOSE 3306

HEALTHCHECK --start-period=5m \
	CMD mariadb -e 'SELECT @@datadir;' || exit 1

ENTRYPOINT [ "sh", "/tmp/secure_installation.sh" ]

CMD ["mysqld_safe", "--user=mysql"]
