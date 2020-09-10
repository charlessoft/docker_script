#!/bin/bash
docker run -p 5044:5044 -p 5045:5045 \
    --name lst -d  \
    -v ${PWD}/config/logstash.conf:/usr/share/logstash/config/logstash.conf \
    -v ${PWD}/config/logstash.yml:/usr/share/logstash/config/logstash.yml \
    logstash:7.3.2 -f /usr/share/logstash/config/logstash.conf



    # -v /etc/localtime:/etc/localtime \
