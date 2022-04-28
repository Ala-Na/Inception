#!/bin/bash

# Mainly inspired and simplified from https://github.com/MariaDB/mariadb-docker/ official image 10.2
# Adjustments principally from https://bertvv.github.io/notes-to-self/2015/11/16/automating-mysql_secure_installation/
# and http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/

sed -i 's/port\s*=\s*3306/port = 3306/' /etc/my.cnf

set -o errexit # abort on nonzero existatus
set -o nounset # abort on unbound variable

# Initialize database
if [ ! -f /var/lib/mysql/mysql ]; then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm > /dev/null
fi

# Secure installation instructions followed by setup of a database which will be used by wordpress
# https://mariadb.com/kb/en/database-for-wordpress/
mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap << _EOF_

FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';
DROP DATABASE test;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

CREATE DATABASE $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PWD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';

FLUSH PRIVILEGES;

_EOF_

# Launch of mariadb with correct user
exec /usr/bin/mysqld --user=mysql
