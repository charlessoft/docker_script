#!/bin/bash
FOLDER=/Users/charles/Downloads/cqtest
CA=${FOLDER}/ca.crt
CLINET_KEY=${FOLDER}/cqtest.key
CLIENT_CERT=${FOLDER}/cqtest.crt
OVPN_FILE=${FOLDER}/cqtest.ovpn
TA_KEY=${FOLDER}/ta.key
SINGLE_OVPN_FILE=/tmp/a.single.ovpn




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




