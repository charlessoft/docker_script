#!/bin/bash

source ./config.sh

echo ${OPENVPN_SERVER}

# 网卡
echo ${INTERFACE}


VPNSEVER=
yum install gcc -y
sh install.sh

yum install gcc net-tools traceroute -y
sh ovpn_config_server.sh
sed -i "s/47.96.250.238/${OPENVPN_SERVER}/g" ./client.conf

# 开始内核转发
echo "net.ipv4.ip_forward = 1" >>  /etc/sysctl.conf
sysctl -p

# 关闭selinux
systemctl stop firewalld.service
systemctl disable firewalld.service
sed -i 's/enforcing/disabled/g' /etc/selinux/config
# 即时生效
setenforce 0


echo "iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o ${INTERFACE} -j SNAT --to-source ${IPADDRESS}"


sh ovpn_create_user.sh user1
sh ovpn_create_user.sh user2

cp /etc/openvpn/client/keys/single/user1.ovpn /tmp/
cp /etc/openvpn/client/keys/single/user2.ovpn /tmp/
