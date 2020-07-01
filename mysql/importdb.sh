#!/bin/bash
source ./config.sh

if [ $# != 1 ]
then
    echo "eg: sh import.sh dbname xx/bak_xx.sql"
    exit 1;
fi

grep "^log-bin" /etc/my.cnf
if [ $? -eq 0 ]; then
    echo "binlog开启状态,先请关闭binlog选项"
    exit 1
fi

echo "======="
echo "mysql ip:" $MYSQL_IP
echo "mysql user: root"
echo "mysql password:" ${ROOT_PASSWORD}
echo "sql: " $1
echo "======="
read -p "请确认[y/n]" -n 1 confirm  #输入一个字符的时候就执行
echo -e '\n'  # 输出换行符
echo $confirm
# case $confirm in
# (N | n)
#       echo "ok, good bye"
#       exit 1;;
# (*)
#       echo "error choice"
#       exit 1;;
# esac
if [ -z $confirm ]; then
    echo "请输入y/n";
    exit 1
else
    if [ $confirm != 'y' ]; then
        exit 1
    fi
fi



fullfile=$1
#fullname="${fullfile##*/}"
#dir="${fullfile%/*}"
#extension="${fullname##*.}"
#filename="${fullname%.*}"
# echo $dir , $fullname , $filename , $extension

#docker cp ${fullfile} ${CONTAINER_NAME}:/tmp/
echo "导入时间:" `date "+%Y-%m-%d %H:%M:%S"`
COMMAND="mysql -h ${MYSQL_IP} -uroot -p${ROOT_PASSWORD} < /tmp/bak.sql"
echo $COMMAND
#docker exec -it ${CONTAINER_NAME} /bin/bash -c "${COMMAND}"

TMP_CONTANER=importdb_tmpmysql

docker ps -a|grep $TMP_CONTANER
if [ $? -eq 0 ]; then
    echo "容器存在${TMP_CONTANER},停止导入数据库,请联系管理员"
    exit 1
else
    echo "容器不存在,开始创建容器${TMP_CONTANER}导入数据"
fi

docker run -it --rm --name ${TMP_CONTANER} -v ${fullfile}:/tmp/bak.sql ${MYSQLIMAGE} /bin/sh -c "$COMMAND"

if [ $? -eq 0 ]; then
    echo "导入${fullfile} 脚本成功:)"
else
    echo "导入${fullfile} 脚本失败:("
fi
