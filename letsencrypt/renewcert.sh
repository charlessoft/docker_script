#!/bin/bash
source ./config.sh
docker run --rm -p 80:80 -p 443:443 \
    -v ${https_folder}:/etc/letsencrypt \
    quay.io/letsencrypt/letsencrypt renew \
    --standalone
