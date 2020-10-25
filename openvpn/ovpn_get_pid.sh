#!/bin/bash
ps -ef|grep openvpn| grep -v "grep" | grep -v ovpn_get_pid |awk '{print $2}'|sed -n '1p'
