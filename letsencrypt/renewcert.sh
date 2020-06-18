#!/bin/bash
source ./config.sh
service nginx stop
docker run --rm -p 80:80 -p 443:443 \
    -v ${https_folder}:/etc/letsencrypt \
    quay.io/letsencrypt/letsencrypt renew \
    --standalone
service nginx start
