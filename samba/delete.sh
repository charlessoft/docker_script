#!/bin/bash
username=$1
config_name=`echo "$1" | tr 'A-Z' 'a-z'`
config_path=$config_name'.smb.conf'

pdbedit -x -u $username

userdel -r $username

rm -fr "/etc/samba/config/${config_path}"
