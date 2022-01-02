#!/bin/bash
CONTAINER_NAME=filebeat
IMAGE=store/elastic/filebeat:7.3.2
LOGSTASH_CONTAINER_NAME=logstash


# ES_IP=localhost
# ES_BACKUP=${PWD}/es_backup

# ES_DATA=${PWD}/data
# ES_CONFIG=${PWD}/config
# ES_PLUGINS=${PWD}/plugins

FILEBEAT_DATA=/tmp/openvpn_filter
export IMAGE
