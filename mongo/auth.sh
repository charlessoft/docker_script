#!/bin/bash
source ./config.sh
docker-compose -f docker-compose.yml exec mongo bash -c "mongo localhost:27017/admin -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD} /tmp/auth.js"
