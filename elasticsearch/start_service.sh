#!/bin/bash
. ./config.sh
docker run \
    -p 9200:9200 \
    -e TAKE_FILE_OWNERSHIP=111 \
    --name ${CONTAINER_NAME} -d ${ESIMAGE}

    # -v ${PWD}/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
