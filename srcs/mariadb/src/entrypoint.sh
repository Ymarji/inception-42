#!/bin/bash
if [ ! -d "/var/lib/mysql/$WORDPRESS_DB_NAME" ];
then
    mysql_install_db

    /etc/init.d/mariadb start

    sleep 2

    echo "installing mysql"
    # Make sure that NOBODY can access the server without a password
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "create user '$WORDPRESS_DB_USER'@'%' identified by '$WORDPRESS_DB_PASSWORD'"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE $WORDPRESS_DB_NAME"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON $WORDPRESS_DB_NAME.* to '$WORDPRESS_DB_USER'@'%'"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES"

    echo "mysql installed"

    echo "mysql stopping"
    mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

    # /etc/init.d/mariadb stop
fi
echo "starrting -----"
mysqld_safe
