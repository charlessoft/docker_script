#!/bin/bash
if [ $# != 1 ] ; then
echo "USAGE: sh $0 port"
echo " e.g.: sh $0 8888"
exit 1;
fi

port=$1
sudo firewall-cmd --zone=public --remove-port=${port}/tcp --permanent

