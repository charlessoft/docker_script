#!/bin/bash

VPNSEVER=
sh install.sh
sh ovpn_config_server.sh
sed -i "s/47.96.250.238/${VPNSEVER}/g" ./client.conf

# 开始内核转发
echo "net.ipv4.ip_forward = 1" >>  /etc/sysctl.conf
sysctl -p

# 关闭selinux
systemctl stop firewalld.service
systemctl disable firewalld.service
sed -i 's/enforcing/disabled/g' /etc/selinux/config
# 即时生效
setenforce 0
