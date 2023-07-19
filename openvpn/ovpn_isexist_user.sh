#!/bin/bash

set -e
OVPN_USER_KEYS_DIR=/etc/openvpn/client/keys
EASY_RSA_VERSION=easyrsa3
EASY_RSA_DIR=/root/openvpn/softs/easy-rsa

user=$1
echo $user

if [ "$user" = "" ]
then
    echo "user is not set!"
    exit 1
else
    # ls /etc/openvpn/client/keys/$user
    ls /root/openvpn/softs/easy-rsa/easyrsa3/pki/private/$user.key
    # ls /tmp/keys/$user
    #echo "/tmp/keys/$user"

    if [ $? -ne 0  ]; then
        echo "${user} is not found"
        exit 1
    else
        echo "success"
        exit 0
    fi

fi


exit 0

