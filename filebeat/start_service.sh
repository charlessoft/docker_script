#!/bin/bash
source ./config/config.sh
# docker run -p 5044:5044 -p 5045:5045 \
#     --name lst -d  \
#     -v ${PWD}/config/logstash.conf:/usr/share/logstash/config/logstash.conf \
#     -v ${PWD}/config/logstash.yml:/usr/share/logstash/config/logstash.yml \
#     ${IMAGE} -f /usr/share/logstash/config/logstash.conf

docker run \
    --link logstash:logstash \
    --restart=always \
    --log-driver json-file \
    --log-opt max-size=100m \
    --log-opt max-file=20  \
    --name filebeat \
    --user=root -d  \
    -v ${FILEBEAT_DATA}:/logs/ \
    -v ${PWD}/ret:/tmp/ret/ \
    -v ${PWD}/config/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml  \
    ${IMAGE}



    # -v /etc/localtime:/etc/localtime \
    # -v ${PWD}/ret:/tmp/ret/ \
