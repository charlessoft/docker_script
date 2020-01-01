#!/bin/bash
source ./config.sh
echo ${PRIVATE_REGISTRY}
docker-compose up -d
