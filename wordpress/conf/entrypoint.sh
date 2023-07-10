#!/bin/sh
if [ ! -d "/run/php" ]
then
    mkdir -p /run/php && \
    echo "Directory created." 
fi
# wp --allow-root core download
# cp wp-config-sample.php wp-config.php 
# # wp --allow-root core config --dbhost=mariadb --dbname=wordpress --dbuser=user --dbpass=root
# wp --allow-root config create
# wp --allow-root core install --url=example.com --title=Example --admin_user=user --admin_password=root --admin_email=info@example.com

echo "<?php phpinfo();?>" > /var/www/html/index.php

exec "$@"