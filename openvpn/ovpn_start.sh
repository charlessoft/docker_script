#!/bin/bash
/usr/local/sbin/openvpn --config /etc/openvpn/server/server.conf &
if [ $? -eq 0 ]; then
    echo "openvpn run succeed"
else
    echo "openvpn run failed"
fi
