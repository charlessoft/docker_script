#!/bin/bash
source ./wordpress_config.sh
docker rm -f ${WORDPRESS_CONTAINER}
