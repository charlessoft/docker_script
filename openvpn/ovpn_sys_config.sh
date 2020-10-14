#!/bin/bash

SYSCTL_FILE=/etc/sysctl.conf

grep "ip_forward" ${SYSCTL_FILE} >> /dev/null
if [ $? -eq 0 ]; then
    echo "succeed"
else
    # 配置内核转发
    echo "net.ipv4.ip_forward = 1" >>  /etc/sysctl.conf
    sysctl -p

    # 关闭selinux
    systemctl stop firewalld.service
    systemctl disable firewalld.service
    sed -i 's/enforcing/disabled/g' /etc/selinux/config
    # 即时生效
    setenforce 0

fi



