#!/bin/bash

# Mainly inspired and simplified from https://github.com/MariaDB/mariadb-docker/ official image 10.2
# Adjustments principally from https://bertvv.github.io/notes-to-self/2015/11/16/automating-mysql_secure_installation/
# and http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/

set -o errexit # abort on nonzero existatus
set -o nounset # abort on unbound variable

echo $MYSQL_USER $MYSQL_PWD

# Initialize database
if [ ! -f /var/lib/mysql/mysql ]; then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm > /dev/null
fi

# Secure installation instructions followed by setup of a database which will be used by wordpress
# https://mariadb.com/kb/en/database-for-wordpress/
mysqld --user=mysql << _EOF_

UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ROOT_PWD') WHERE User='root';
DROP DATABASE test;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

CREATE DATABASE $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PWD';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;


FLUSH PRIVILEGES;
_EOF_

sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

# Launch of mariadb with correct user
exec /usr/bin/mysqld --user=mysql

##!/bin/sh

#if [ ! -d "/run/mysqld" ]; then
#	mkdir -p /run/mysqld
#	chown -R mysql:mysql /run/mysqld
#fi

#if [ ! -d "/var/lib/mysql/mysql" ]; then
	
#	chown -R mysql:mysql /var/lib/mysql

#	# init database
#	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

#	tfile=`mktemp`
#	if [ ! -f "$tfile" ]; then
#		return 1
#	fi

#	# https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
#	cat << EOF > $tfile
#USE mysql;
#FLUSH PRIVILEGES;

#DELETE FROM	mysql.user WHERE User='';
#DROP DATABASE test;
#DELETE FROM mysql.db WHERE Db='test';
#DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

#ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';

#CREATE DATABASE $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
#CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PWD';
#GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';

#FLUSH PRIVILEGES;
#EOF
#	# run init.sql
#	/usr/bin/mysqld --user=mysql --bootstrap < $tfile
#	rm -f $tfile
#fi

## allow remote connections
#sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
#sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

#echo HERE

#exec /usr/bin/mysqld --user=mysql --console
