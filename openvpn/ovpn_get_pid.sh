#!/bin/bash
SCRIPT=`basename $0`
export CURPWD=$(cd `dirname $0`; pwd)
pid=`ps -ef|grep openvpn| grep -v "grep" | grep -v "ovpn_get_pid" | grep -v "ovpn_get_running_time"`
if [ $? -eq 0 ]; then
    echo $pid |awk '{print $2}'|sed -n '1p' > ${CURPWD}/pid.txt
else
    echo "not process openvpn" >&2
    exit 1
fi

