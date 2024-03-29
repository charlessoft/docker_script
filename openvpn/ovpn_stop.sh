#!/bin/bash
function stop_name()
{
	echo "close $1 pid"
	pid=`ps -ef|grep $1|grep -v "grep"|grep -v "stopServer" | grep -v "ovpn_del_user" |awk '{print $2}'`
	if [ x"$pid" != x"" ]
	then
		echo "$pid is running...close it!"
		kill -9 ${pid}
	fi
}

stop_name 'openvpn'
exit 0
