#!/bin/bash
# root / pa44w0rd
#mysql.server start
source ./config.sh
docker run -p ${PORT}:3306 \
    --name ${CONTAINER_NAME} \
    -v ${DOCKER_MYSQL_CONFIG}:/etc/mysql/conf.d \
    -v ${PWD}/mysql/data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=${ROOT_PASSWORD} \
    -d ${MYSQLIMAGE}

