FROM debian:bullseye

ARG PORTAINER_ADMIN_PASSWORD

ARG PORTAINER_ADMIN_PASSWORD 
RUN apt update
RUN apt upgrade -y
RUN apt install -y wget ca-certificates curl jq apache2-utils
RUN echo -n $PORTAINER_ADMIN_PASSWORD > /tmp/file.txt

# RUN mkdir -p /home/test && \
#     addgroup -S portainer && \
#     adduser -S -D -g "" -G portainer -s /bin/sh -h /home/test portainer && \
#     chown portainer:portainer /home/test

RUN curl -sSL https://github.com/portainer/portainer/releases/download/2.18.4/portainer-2.18.4-linux-amd64.tar.gz | \
 tar -xzo -C /usr/local

EXPOSE 9443
CMD ["/usr/local/portainer/portainer", "--admin-password-file=/tmp/file.txt"]
