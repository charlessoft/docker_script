#!/bin/bash
export SERVER=server

cp vars softs/easy-rsa/easyrsa3/
cd softs/easy-rsa/easyrsa3

#1. 目录初始化
./easyrsa init-pki

#2. 创建根证书
# ./easyrsa build-ca nopass
# ./easyrsa build-ca nopass  #生成 CA 根证书, 输入 Common Name，名字随便起。
./easyrsa --batch build-ca nopass > /dev/null 2>&1 || return 1



./easyrsa build-server-full $SERVER nopass
./easyrsa gen-dh
/usr/local/sbin/openvpn --genkey --secret ta.key



mkdir -p /etc/openvpn/server/certs && cd /etc/openvpn/server/certs/
cp /root/openvpn/softs/easy-rsa/easyrsa3/pki/dh.pem ./     # SSL 协商时 Diffie-Hellman 算法需要的 key
cp /root/openvpn/softs/easy-rsa/easyrsa3/pki/ca.crt ./        # CA 根证书
cp /root/openvpn/softs/easy-rsa/easyrsa3/pki/issued/server.crt ./    # open VPN 服务器证书
cp /root/openvpn/softs/easy-rsa/easyrsa3/pki/private/server.key ./   # open VPN 服务器证书 key
cp /root/openvpn/softs/easy-rsa/easyrsa3/ta.key ./   # tls-auth key
cp /root/openvpn/server.conf ./


# 创建 open VPN 日志目录
mkdir -p /var/log/openvpn/
# chown openvpn:openvpn /var/log/openvpn



cp server.conf /etc/openvpn/server
