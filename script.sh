#/bin/bash
sudo -i

curl -SL https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-x86_64 -o /opt/bin/docker-compose

chmod +x /opt/bin/docker-compose