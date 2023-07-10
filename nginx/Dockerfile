FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y nginx vim

WORKDIR /etc/nginx
COPY --chown=www-data:www-data ./conf/default.conf sites-enabled/default

RUN apt install -y openssl
RUN openssl req -x509 -nodes -days 365 -subj "/C=MA/ST=KH/L=KHOURIBGA/O=1337Ltd/OU=OCP/OU=OCP SA/emailAddress=ymarji@student.1337.ma" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;
WORKDIR /

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]