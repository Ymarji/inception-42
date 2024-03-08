FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y

RUN apt install -y nginx git
RUN rm -rf /var/www/html
RUN git clone https://github.com/Ymarji/ymarji.github.io.git /var/www/html/

RUN sed -i 's/listen 80 default_server;/listen 8080 default_server;/' /etc/nginx/sites-available/default
RUN sed -i 's/listen \[::\]:80/listen \[::\]:8080/' /etc/nginx/sites-available/default


EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
