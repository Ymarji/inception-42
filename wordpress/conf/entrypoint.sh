#!/bin/sh
if [ ! -d "/run/php" ]
then
    mkdir -p /run/php && \
    echo "Directory created." 
fi

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else
wp core download --allow-root
cp wp-config-sample.php wp-config.php
wp config set DB_NAME $WORDPRESS_DB_NAME --allow-root
wp config set DB_USER $WORDPRESS_DB_USER --allow-root
wp config set DB_PASSWORD $WORDPRESS_DB_PASSWORD --allow-root
wp config set DB_HOST $WORDPRESS_DB_HOST --allow-root
wp core install --url=$WORDPRESS_HOST --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_USER_NAME --admin_password=$WORDPRESS_USER_PASSWORD --admin_email=$WORDPRESS_USER_EMAIL --allow-root
# echo "<?php phpinfo();?>" > /var/www/html/index.php
fi
exec "$@"