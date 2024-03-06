FROM debian:bullseye

RUN apt update
RUN apt upgrade -y
RUN apt install -y redis

RUN sed -i -r "s/bind 127.0.0.1/#bind 127.0.0.0/" /etc/redis/redis.conf
EXPOSE 6379

CMD ["redis-server",  "--protected-mode", "no"]