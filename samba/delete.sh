#!/bin/bash
username=$1
pdbedit -x -u $username

userdel -r $username

rm -fr "/etc/samba/config/${username}.smb.conf"
