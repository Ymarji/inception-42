FROM debian:bullseye

RUN apt-get update
RUN apt-get -y upgrade
RUN apt install -y vsftpd vim tini

RUN mv /etc/vsftpd.conf /etc/default_vsftpd.conf
COPY ./conf/vsftpd.conf /etc/vsftpd.conf

RUN mkdir -p /var/run/vsftpd/empty


COPY --chmod=744 ./conf/entrypoint.sh /tmp/
# ENTRYPOINT [ "/tmp/entrypoint.sh", "--" ]
# CMD [ "vsftpd" ]

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD [ "/tmp/entrypoint.sh", "--", "vsftpd" ]