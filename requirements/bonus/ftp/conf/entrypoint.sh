#!/bin/bash

service vsftpd start

useradd $FTP_USER -g www-data -d /var/www/html/wordpress
 
echo -e "$FTP_PASS\n$FTP_PASS" | passwd $FTP_USER

# chown $FTP_USER:www-data -R /var/www/html/wordpress

# usermod -d /var/www/html/wordpress $FTP_USER

service vsftpd stop
echo "==============>" "$@"
exec "$@"
