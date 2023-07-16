FROM debian:buster

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y \
    wget \
    php php-curl libapache2-mod-php php-cli php-mysql php-gd php-fpm

RUN mkdir -p /run/php
RUN mkdir -p /var/run/
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY --chmod=755 ./conf/entrypoint.sh /tmp/entrypoint.sh

RUN mkdir /var/www/html/adminer
# WORKDIR /var/www/html/adminer
WORKDIR /var/www/html/adminer

EXPOSE 8888
ENTRYPOINT [ "/tmp/entrypoint.sh" ]
CMD ["php-fpm7.3", "-F"]