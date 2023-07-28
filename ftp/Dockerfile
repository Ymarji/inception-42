FROM debian:buster

RUN apt-get update
RUN apt-get -y upgrade
RUN apt install -y vsftpd

EXPOSE 20

CMD [ "tail","-f" ]
