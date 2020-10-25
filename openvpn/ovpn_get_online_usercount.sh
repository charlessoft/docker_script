#!/bin/bash
SCRIPT=`basename $0`
export CURPWD=$(cd `dirname $0`; pwd)

sh ${CURPWD}/ovpn_get_online_user.sh |wc -l
