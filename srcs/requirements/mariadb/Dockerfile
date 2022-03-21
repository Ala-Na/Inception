# Mainly inspired and simplified from https://github.com/MariaDB/mariadb-docker 10.2
# Adjustments from https://mariadb.com/kb/en/creating-a-custom-docker-image/
# and https://sysdig.com/blog/dockerfile-best-practices/
# and https://wiki.alpinelinux.org/wiki/MariaDB

FROM alpine:3.14

# creation of new group and user mysql to avoid rootless container
RUN set -e; \
	adduser -D -g 'mysql' mysql

# install of mariadb server and recreate files with correct permissions
RUN apk update \
	&& apk upgrade \
	&& apk add vim mariadb; \
	rm -rf /var/lib/apt/lists/*; \
	# note that /var/lib/mysql is the fault directory where MySQL by default will write its data files
	rm -rf /var/lib/mysql; \
	# note that /var/run/mysqld is the file used for socket and lock files
	mkdir -p /var/lib/mysql /var/run/mysqld; \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; \
	chmod 777 /var/run/mysqld; \
	# comment bind-address which can be problematic
	# bind address is set such as server only listen to localhost by default
	find /etc/mysql/ -name '*.cnf' -print0 \
	| xargs -0 grep -lE '^(bind-address|log|user\s)' \
	| xargs -rt -0 sed -Ei 's/^(bind-address|log|user\s)/#&/'; \
	sed -i "s|.*skip-networking.*|skip-networking|g" /etc/mysql/my.cnf ; \
	sed -i "s|.*skip-networking.*|skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

COPY conf/secure_installation.sh /tmp/secure_installation.sh

# Container default port must be exposed
# No effect if port is not exposed at container creation
EXPOSE 3306

HEALTHCHECK --start-period=5m \
	CMD mariadb -e 'SELECT @@datadir;' || exit 1

ENTRYPOINT [ "sh", "/tmp/secure_installation.sh" ]

CMD ["mysqld_safe", "--user=mysql"]
