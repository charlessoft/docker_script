#!/bin/bash
source ./config.sh
docker run --rm -p 80:80 -p 443:443 \
    -v ${https_folder}:/etc/letsencrypt \
    quay.io/letsencrypt/letsencrypt auth \
    --standalone -m hello@email.com --agree-tos \
    -d ${host}

echo "=====ssl info====="
echo "ssl_certificate ${https_folder}/${host}/live/${host}/fullchain.pem;"
echo "ssl_certificate_key ${https_folder}/${host}/live/${host}/privkey.pem;"
echo "ssl_trusted_certificate ${https_folder}/${host}/live/${host}/fullchain.pem;"
echo "=====ssl info====="
