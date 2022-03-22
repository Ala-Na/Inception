#!/bin/bash

# Mainly inspired and simplified from https://github.com/MariaDB/mariadb-docker/ official image 10.2
# Adjustments principally from https://bertvv.github.io/notes-to-self/2015/11/16/automating-mysql_secure_installation/
# and http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/


set -o errexit # abort on nonzero existatus
set -o nounset # abort on unbound variable

# initialize database
if [ ! -f /var/lib/mysql/mysql ]; then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm > /dev/null
fi

# secure installation
# TODO fix password and maybe create database ?
mysqld --user=mysql << _EOF_
UPDATE mysql.user SET Password=PASSWORD(${MYSQL_ROOT_PWD}) WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';

FLUSH PRIVILEGES;
_EOF_

exec /usr/bin/mysqld_safe --user=mysql
