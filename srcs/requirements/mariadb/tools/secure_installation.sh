#!/bin/bash

# From https://bertvv.github.io/notes-to-self/2015/11/16/automating-mysql_secure_installation/

set -o errexit # abort on nonzero existatus
set -o nounset # abort on unbound variable

is_mysql_command_available() {
	which mysql > /dev/null 2>&1
}

if ! is_mysql_command_available; then
	echo "The MySQL/MariaDB is not installed"

mysql --user=root << _EOF_
UPDATE mysql.user SET Password=PASSWORD('diffpasswordformysql') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
_EOF_
