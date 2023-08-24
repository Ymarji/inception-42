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

chown www-data:www-data -R /var/www/html/wordpress
# set wp database config
wp config set DB_NAME $WORDPRESS_DB_NAME --allow-root
wp config set DB_USER $WORDPRESS_DB_USER --allow-root
wp config set DB_PASSWORD $WORDPRESS_DB_PASSWORD --allow-root
wp config set DB_HOST $WORDPRESS_DB_HOST --allow-root

sleep 8

wp core install --url=$WORDPRESS_HOST --title=$WORDPRESS_TITLE --admin_user=$WP_ROOT_USER_NAME --admin_password=$WP_ROOT_USER_PASSWORD --admin_email=$WP_ROOT_USER_EMAIL --allow-root
wp user create $WP_USER $WP_USER_MAIL --user_pass=$WP_USER_PASS --allow-root

wp plugin install redis-cache --activate --allow-root

# set wp redis config
wp config set WP_REDIS_HOST $REDIS_HOST --allow-root
wp config set WP_REDIS_PORT $REDIS_PORT --allow-root
wp config set WP_REDIS_PREFIX $REDIS_DB_PREFIX --allow-root
wp config set WP_REDIS_TIMEOUT 1 --allow-root
wp config set WP_REDIS_READ_TIMEOUT 1 --allow-root

wp redis enable --allow-root

wp theme install twentynineteen --allow-root
wp theme activate twentytwentythree --allow-root

# wp plugin install wp-dummy-content-generator --allow-root
# wp plugin activate wp-dummy-content-generator --allow-root
curl -N https://loripsum.net/api/5 | wp post generate --post_content --count=10 --allow-root
fi
exec "$@"