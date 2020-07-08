#!/bin/bash
CONTAINER_NAME=myes
ESIMAGE=elasticsearch:5.4.3


ES_IP=localhost
ES_BACKUP=${PWD}/es_backup

ES_DATA=${PWD}/data
ES_CONFIG=${PWD}/config
ES_PLUGINS=${PWD}/plugins

export ESIMAGE
