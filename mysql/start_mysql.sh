#!/bin/bash
# root / pa44w0rd
#mysql.server start
docker run -p 3306:3306 \
    --name mysql \
    -v ${PWD}/conf:/etc/mysql/conf.d \
    -v ${PWD}/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root  -d mysql:5.7.23

