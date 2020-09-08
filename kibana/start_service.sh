#!/bin/bash
# docker pull docker.elastic.co/kibana/kibana:7.3.2

# docker run -it -d -e \
#     ELASTICSEARCH_URL=${ELASTICSEARCH_URL} \
#     --name kibana \
#     -p ${KIBANA_PORT}:5601 \
#     docker.elastic.co/kibana/kibana:7.3.2


docker run -d --name kibana -p 5601:5601 -v ${PWD}/kibana.yml:/usr/share/kibana/config/kibana.yml kibana:7.3.2
