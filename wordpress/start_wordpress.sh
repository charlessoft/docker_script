#!/bin/bash
source ./config.sh

# link
# docker run --restart=always -d --name ${WORDPRESS_CONTAINER} \
# 	--env WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}\
#     -p ${WORDPRESS_PORT}:80 \
#     -v ${PWD}/wp-app:/var/www/html \
#     -v ${PWD}/theme-name/dux/:/var/www/html/wp-content/themes/dux \
#     -v ${PWD}/conf/php.conf.ini:/usr/local/etc/php/conf.d/conf.ini \
#     --link ${SQLDB_CONTAINER}:mysql \
#     ${WORDPRESS_IMAGE}



docker run --restart=always -d \
    --name ${WORDPRESS_CONTAINER} \
    -e WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST} \
    -e WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD} \
    -e WORDPRESS_DB_USER=${WORDPRESS_DB_USER} \
    -e WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME} \
     -p ${WORDPRESS_PORT}:80 \
     -v ${PWD}/wp-app:/var/www/html \
     -v ${PWD}/theme-name/dux/:/var/www/html/wp-content/themes/dux \
     -v ${PWD}/conf/php.conf.ini:/usr/local/etc/php/conf.d/conf.ini \
     ${WORDPRESS_IMAGE}

# ===== wordpress 配置 =====#
