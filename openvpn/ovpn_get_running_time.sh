#!/bin/bash
SCRIPT=`basename $0`
export CURPWD=$(cd `dirname $0`; pwd)
sh ${CURPWD}/ovpn_get_pid.sh

pid=`cat $CURPWD/pid.txt`
if [ $? -eq 0 ]; then
    ps -p $pid -o etimes | sed -n '2p'
else
    exit 1
fi

