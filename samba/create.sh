#!/bin/bash

username=$1
password=`echo -n "$2"|md5sum|cut -d ' ' -f1`
# 配置文件必须要小写
config_name=`echo "$1" | tr 'A-Z' 'a-z'`
config_path=$config_name'.smb.conf'
group=$3


egrep "^$group" /etc/group >& /dev/null
if [ $? -ne 0 ];then
    groupadd $group
fi
if [ ! -d "/data/$group" ]; then
    mkdir -p /data/$group
    chmod 770 -R /data/$group
    chown -R :$group /data/$group
fi

pdbedit -L | grep "^$username:" &>/dev/null
if [ $? -ne 0 ]; then
    useradd  -s /sbin/nologin -G $group $username
    echo "$password" | passwd --stdin $username 1>/dev/null 2>>addsmbuser.log
    echo -e "$password\n$password" | pdbedit -a -t -u $username 2>>addsmbuser.log
    if [ $? -eq 0 ]; then
        echo "$username 创建成功"
    else
        echo "错误"
            exit 1
    fi
else
    echo -e "$username 已存在"
fi

mkdir -p /data/$username
chown -R $username:$username /data/$username
chmod 700 -R /data/$username

mkdir -p /etc/samba/config
cat>/etc/samba/config/${config_path}<<EOF
#cat>/etc/samba/config/mydemo.smb.conf<<EOF
[$username]
        security = user
        path = /data/$username
        valid users = @$username
        read list = @$username
        write list = @$username
        writable = yes
        create mask = 0777
        directory mask = 0777

[public]
        comment = 公共文件
        path = /data/sc
        #valid users = @sc
        writable = yes
        #write list = @sc
EOF

systemctl restart smb
echo "net use u: \\\\10.8.0.1\\${username} \"${password}\" /user:\"${username}\""
