#!/bin/bash
source ./wordpress_config.sh

docker run --restart=always -d --name ${WORDPRESS_CONTAINER} \
	--env WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}\
    -p 8080:80 \
    -v ${PWD}/wp-app:/var/www/html \
    -v ${PWD}/theme-name/dux/:/var/www/html/wp-content/themes/dux \
    -v ${PWD}/config/php.conf.ini:/usr/local/etc/php/conf.d/conf.ini \
    --link ${SQLDB_CONTAINER}:mysql \
    ${WORDPRESS_IMAGE}
