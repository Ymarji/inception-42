FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install mariadb-server mariadb-client -y tini

# RUN mkdir -p /var/run/mysqld \
# && chown -R mysql:mysql /var/run/mysqld \
# && chmod 777 /var/run/mysqld

COPY ./src/entrypoint.sh /
COPY ./src/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD [ "/entrypoint.sh" ]