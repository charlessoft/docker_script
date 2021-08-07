#!/bin/bash

if [ $# != 1 ] ; then
echo "USAGE: $0 user"
echo " e.g.: $0 user1"
exit 1;
fi

user=$1
FOLDER=/etc/openvpn/client/keys/${user}
SINGLE_OVPNFILE_FOLDER=/etc/openvpn/client/keys/single/
SINGLE_OVPN_FILE=${SINGLE_OVPNFILE_FOLDER}/${user}.ovpn
SINGLE_OVPN_BAK_FILE=${SINGLE_OVPNFILE_FOLDER}/${user}_bak.ovpn

echo "cp  ${SINGLE_OVPN_BAK_FILE} ${SINGLE_OVPN_FILE}"
cp  ${SINGLE_OVPN_BAK_FILE} ${SINGLE_OVPN_FILE}

# echo `cat ${}`
exit 0
