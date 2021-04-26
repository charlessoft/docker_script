#!/bin/bash

set -e
OVPN_USER_KEYS_DIR=/etc/openvpn/client/keys
EASY_RSA_VERSION=easyrsa3
EASY_RSA_DIR=/root/openvpn/softs/easy-rsa
for user in "$@"
do
  cd $EASY_RSA_DIR/$EASY_RSA_VERSION
  echo -e 'yes\n' | ./easyrsa revoke $user
  ./easyrsa gen-crl
  # 吊销掉证书后清理客户端相关文件
  if [ -d "$OVPN_USER_KEYS_DIR/$user" ]; then
    rm -rf $OVPN_USER_KEYS_DIR/${user}*
  fi
#  systemctl restart openvpn@server
done
echo "请执行sh ovpn_restart.sh; 重启服务"
cd /root/openvpn
sh ovpn_stop.sh 
sh ovpn_start.sh

exit 0
