#!/bin/bash 
# root / pa44w0rd
#mysql.server stop
source ./config.sh
docker rm -f ${CONTAINER_NAME}
