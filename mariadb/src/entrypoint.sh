#!/bin/bash
mysql_install_db

/etc/init.d/mysql start
sleep 2
# Make sure that NOBODY can access the server without a password
# mysql -u root -e "UPDATE mysql.user SET Password = PASSWORD('CHANGEME') WHERE User = 'root'"
# # Kill the anonymous users
# mysql -u root -e "DROP USER ''@'localhost'"
# # Because our hostname varies we'll use some Bash magic here.
# mysql -u root -e "DROP USER ''@'$(hostname)'"
# # Kill off the demo database
# mysql -u root -e "DROP DATABASE test"
# # Any subsequent tries to run queries this way will get access denied because lack o
mysql -u root -e "create user 'user'@'%' identified by 'root'"

mysql -u root -e "CREATE DATABASE wordpress"

mysql -u root -e "GRANT ALL ON wordpress.* to 'user'@'%'"

mysql -u root -e "FLUSH PRIVILEGES"

sleep 2

/etc/init.d/mysql stop

sleep 2
mysqld_safe
# exec "$@"