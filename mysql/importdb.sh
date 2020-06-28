#!/bin/bash
source ./config.sh

if [ $# != 1 ]
then
    echo "eg: sh import.sh dbname xx/bak_xx.sql"
    exit 1;
fi

fullfile=$1
#fullname="${fullfile##*/}"
#dir="${fullfile%/*}"
#extension="${fullname##*.}"
#filename="${fullname%.*}"
# echo $dir , $fullname , $filename , $extension

#docker cp ${fullfile} ${CONTAINER_NAME}:/tmp/
COMMAND="mysql -h ${MYSQL_IP} -uroot -p${ROOT_PASSWORD} < /tmp/bak.sql"
echo $COMMAND
#docker exec -it ${CONTAINER_NAME} /bin/bash -c "${COMMAND}"

TMP_CONTANER=importdb_tmpmysql

docker ps -a|grep $TMP_CONTANER
if [ $? -eq 0 ]; then
    echo "容器存在${TMP_CONTANER},停止导入数据库,请联系管理员"
    exit 1
else
    echo "容器不存在在,开始创建容器${TMP_CONTANER},导入数据"
fi

docker run -it --rm --name ${TMP_CONTANER} -v ${fullfile}:/tmp/bak.sql ${MYSQLIMAGE} /bin/sh -c "$COMMAND"
echo 运行结果: $?

if [ $? -eq 0 ]; then
    echo "导入${fullfile} 脚本成功:)"
else
    echo "导入${fullfile} 脚本失败:("
fi
