#!/bin/bash
source ./config.sh
sed -i "s/requirepass.*/requirepass\ ${PASSWORD}/g" redis.conf

docker-compose up -d
