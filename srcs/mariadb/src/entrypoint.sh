#!/bin/bash
if [ ! -d "/var/lib/mysql/$WORDPRESS_DB_NAME" ];
then
    mysql_install_db

    /etc/init.d/mariadb start

    # sleep 2
    start_time=$(date +%s)
    while ! mysqladmin -u root ping >/dev/null 2>&1; do
        sleep 1
        current_time=$(date +%s)
        elapsed_time=$((current_time - start_time))
        echo "waiting $elapsed_time"


        if [[ $elapsed_time -ge 10 ]]; then
            echo "Timeout: MariaDB server not ready after 10 seconds."
            exit 1
        fi
    done

    echo "installing mysql"
    # Make sure that NOBODY can access the server without a password
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES"
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
