#!/bin/bash
if [ $# != 1 ] ; then
echo "USAGE: sh $0 port"
echo " e.g.: sh $0 8888"
exit 1;
fi
port=$1
echo "开放端口: $port"
sudo firewall-cmd --permanent --add-port=${port}/tcp
