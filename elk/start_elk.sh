#!/bin/bash
docker run -dit --name elk \
    -p 5601:5601  \
    -p 9200:9200  \
    -p 5044:5044  \
    -v ${PWD}/logstash/conf.d:/etc/logstash/conf.d/ \
    -v ${PWD}/logstash/log:/var/log/logstash  \
    -v ${PWD}/kibana/config/:/opt/kibana/config \
    -v ${PWD}/elk-data:/var/lib/elasticsearch  \
    -v /etc/localtime:/etc/localtime  \
    sebp/elk:740

