#!/bin/bash
. config.sh
docker run \
    -p 9200:9200 \
    -v ${PWD}/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
    --name ${CONTAINER_NAME} -d ${ESIMAGE}

