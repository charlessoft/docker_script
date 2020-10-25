#!/bin/bash
SCRIPT=`basename $0`
export CURPWD=$(cd `dirname $0`; pwd)
cat ${CURPWD}/openvpn-status.log | sed -n '/OpenVPN CLIENT LIST/,/ROUTING TABLE/p' | tail -n+4 | sed "s/ROUTING TABLE//g";

