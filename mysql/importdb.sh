#!/bin/bash
source ./config.sh
LOGFILE=${LOG_PATH}/importdb.log

if [ $# != 1 ]
then
    echo "eg: sh import.sh dbname xx/bak_xx.sql"
    exit 1;
fi

echo "导入数据库,操作时间:" `date "+%Y-%m-%d %H:%M:%S"` | tee -a ${LOGFILE}
grep "^log-bin" /etc/my.cnf
if [ $? -eq 0 ]; then
    echo "binlog开启状态,先请关闭binlog选项,并重启mysql服务" | tee -a ${LOGFILE}
    exit 1
fi

echo "------" | tee -a ${LOGFILE}
echo "mysql user: root" | tee -a ${LOGFILE}
echo "mysql password:" ${ROOT_PASSWORD} | tee -a ${LOGFILE}
echo "sql: " $1 | tee -a ${LOGFILE}
echo "------" | tee -a ${LOGFILE}
read -p "请确认[y/n]" -n 1 confirm  #输入一个字符的时候就执行
echo -e '\n'  # 输出换行符
echo $confirm | tee -a ${LOGFILE}
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
echo "导入时间:" `date "+%Y-%m-%d %H:%M:%S"` | tee -a ${LOGFILE}
COMMAND="mysql -uroot -p${ROOT_PASSWORD} < ${fullfile}"
echo $COMMAND | tee -a ${LOGFILE}

if [ "$USE_DOCKER" == "1" ]; then
    TMP_CONTANER=importdb_tmpmysql
    docker ps -a|grep $TMP_CONTANER
    if [ $? -eq 0 ]; then
        echo "容器存在${TMP_CONTANER},停止导入数据库,请联系管理员" | tee -a ${LOGFILE}
        exit 1
    else
        echo "容器不存在,开始创建容器${TMP_CONTANER}导入数据" | tee -a ${LOGFILE}
    fi

    docker run -it --rm --name ${TMP_CONTANER} -v ${fullfile}:/tmp/bak.sql ${MYSQLIMAGE} /bin/sh -c "$COMMAND"
else
    eval $COMMAND
fi
#docker exec -it ${CONTAINER_NAME} /bin/bash -c "${COMMAND}"


if [ $? -eq 0 ]; then
    echo "导入${fullfile} 脚本成功:)" | tee -a ${LOGFILE}
else
    echo "导入${fullfile} 脚本失败:(" | tee -a ${LOGFILE}
fi
echo "======" | tee -a ${LOGFILE}
