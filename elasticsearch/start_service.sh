#!/bin/bash
. ./config.sh
docker run \
    -p 9200:9200 \
    -v ${ES_DATA}:/usr/share/elasticsearch/data \
    -v ${ES_CONFIG}:/usr/share/elasticsearch/config \
    -v ${ES_PLUGINS}:/usr/share/elasticsearch/plugins \
    -v ${ES_BACKUP}:/tmp/es_backup \
    -e TAKE_FILE_OWNERSHIP=111 \
    --name ${CONTAINER_NAME} -d ${ESIMAGE}

    # -v ${PWD}/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
