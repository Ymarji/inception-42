#!/bin/bash
if [ ! -d "/var/lib/mysql" ];
then
    mysql_install_db

    echo "installing mysql"
    mysqld_safe
    # Make sure that NOBODY can access the server without a password
    mysql -u root -e "UPDATE mysql.user SET Password = PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User = 'root'"
    # Kill the anonymous users
    mysql -u root -e "DROP USER ''@'localhost'"
    # Because our hostname varies we'll use some Bash magic here.
    mysql -u root -e "DROP USER ''@'$(hostname)'"
    # Kill off the demo database
    mysql -u root -e "DROP DATABASE test"
    # Any subsequent tries to run queries this way will get access denied because lack
    mysql -u root -e "create user '$WORDPRESS_DB_USER'@'%' identified by '$WORDPRESS_DB_PASSWORD'"
    mysql -u root -e "CREATE DATABASE $WORDPRESS_DB_NAME"
    mysql -u root -e "GRANT ALL ON $WORDPRESS_DB_NAME.* to '$WORDPRESS_DB_USER'@'%'"
    mysql -u root -e "FLUSH PRIVILEGES"

    /etc/init.d/mariadb stop
fi

# mysqld_safe

tail -f /dev/null
