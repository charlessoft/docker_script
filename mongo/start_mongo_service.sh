#!/bin/bash
source ./config.sh
echo $MONGO_DATA_DIR
docker-compose up -d
