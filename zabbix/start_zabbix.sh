#!/bin/bash

# docker run --name zabbix-server-mysql -t \
#       -e DB_SERVER_HOST="mysql" \
#       -e MYSQL_DATABASE="zabbix" \
#       -e MYSQL_USER="root" \
#       -e MYSQL_PASSWORD="pa44w0rd" \
#       -e MYSQL_ROOT_PASSWORD="pa44w0rd" \
#       --link mysql:mysql \
#       -p 10051:10051 \
#       -d zabbix/zabbix-server-mysql:latest

docker run --name zabbix_server -p 8088:80 -p 10051:10051 \
  -v ${PWD}/hgzabbix-data:/var/lib/mysql \
  -v ${PWD}/alertscripts:/usr/lib/zabbix/alertscripts \
  -e PHP_TZ=Asia/Shanghai \
  -v /etc/localtime:/etc/localtime -d zabbix/zabbix-appliance:alpine-4.4.6
