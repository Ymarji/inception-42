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

sleep 8

wp core install --url=$WORDPRESS_HOST --title=$WORDPRESS_TITLE --admin_user=$WP_ROOT_USER_NAME --admin_password=$WP_ROOT_USER_PASSWORD --admin_email=$WP_ROOT_USER_EMAIL --allow-root
# echo "<?php phpinfo();?>" > /var/www/html/index.php
wp user create $WP_USER $WP_USER_MAIL --user_pass=$WP_USER_PASS --allow-root

wp theme install twentynineteen --allow-root
wp theme activate twentynineteen --allow-root
fi
exec "$@"