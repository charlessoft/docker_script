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

CA=${FOLDER}/ca.crt
CLINET_KEY=${FOLDER}/${user}.key
CLIENT_CERT=${FOLDER}/${user}.crt
OVPN_FILE=${FOLDER}/${user}.ovpn
TA_KEY=${FOLDER}/ta.key
mkdir -p $SINGLE_OVPNFILE_FOLDER

if [ ! -f ${CLINET_KEY} ]; then
echo "${CLINET_KEY} 文件不存在,请检查"
exit 1
fi


rm -fr ${SINGLE_OVPN_FILE}

# cat ${OVPN_FILE} | sed -e "s/ca /#ca /g" \o >> ${SINGLE_OVPN_FILE}
cat ${OVPN_FILE} | sed -e "s/^key /#key /g" \
    -e "s/^ca /#ca /g"  \
    -e "s/^cert /#cert /g" \
    -e "s/tls-auth /#tls-auth /g" \
    >> ${SINGLE_OVPN_FILE}

echo "<ca>" >> ${SINGLE_OVPN_FILE}
cat ${CA} >> ${SINGLE_OVPN_FILE}
echo "</ca>" >> ${SINGLE_OVPN_FILE}

echo "<cert>" >> ${SINGLE_OVPN_FILE}
cat ${CLIENT_CERT} >> ${SINGLE_OVPN_FILE}
echo "</cert>" >> ${SINGLE_OVPN_FILE}


echo "<key>" >> ${SINGLE_OVPN_FILE}
cat ${CLINET_KEY} >> ${SINGLE_OVPN_FILE}
echo "</key>" >> ${SINGLE_OVPN_FILE}

echo "key-direction 1" >> ${SINGLE_OVPN_FILE}

echo "<tls-auth>" >> ${SINGLE_OVPN_FILE}
cat ${TA_KEY} >> ${SINGLE_OVPN_FILE}
echo "</tls-auth>" >> ${SINGLE_OVPN_FILE}


# echo `cat ${}`




