#!/bin/bash
source ./config.sh
_os="`uname`"
_now=$(date +"%m_%d_%Y_%H_%M_%S")
LOGFILE=${LOG_PATH}/backupdb.log

: ${BACK_FOLDER:=${MYSQL_BACKUP_FOLDER}}
: ${CONTAINER_NAME:=mysql}
: ${BACK_DATABASE_NAME=wordpress}

echo "备份时间:"`date "+%Y-%m-%d %H:%M:%S"` | tee -a ${LOGFILE}
bak_date=`date "+%Y-%m-%d"`
mkdir -p ${BACK_FOLDER}

for DBNAME in ${BACK_DATABASE_NAME[@]}
do
    mkdir -p ${BACK_FOLDER}/${bak_date}
    BAK_FILE=${BACK_FOLDER}/${bak_date}/${DBNAME}_${_now}_bak.sql
    echo "备份路径:" ${BAK_FILE} | tee -a ${LOGFILE}

    # Export dump
    TMP_CONTAINER=epxport_tmpmysq;
    #EXPORT_COMMAND="mysqldump -h${MYSQL_IP} --databases ${DBNAME} -uroot -p$ROOT_PASSWORD -x"
    EXPORT_COMMAND="mysqldump -hmysql --databases ${DBNAME} -uroot -p$ROOT_PASSWORD -x"
    # docker-compose exec db sh -c "$EXPORT_COMMAND" > $BAK_FILE
    #docker exec -i mysql /bin/bash -c "$EXPORT_COMMAND" > $BAK_FILE
    echo $EXPORT_COMMAND | tee -a ${LOGFILE}
    if [ "$USE_DOCKER" == "1" ]; then
        docker ps -a |grep ${TMP_CONTAINER}
        if [ $? -eq 0 ]; then
            echo "容器存在${TMP_CONTANER},停止导入数据库,请联系管理员" | tee -a ${LOGFILE}
            exit 1
        else
            echo "容器不存在在,开始创建容器${TMP_CONTANER},导出数据" | tee -a ${LOGFILE}
        fi
	echo "docker run -it --rm --name ${TMP_CONTAINER} --link ${CONTAINER_NAME}:mysql ${MYSQLIMAGE}  /bin/bash -c "

        docker run -i --rm --name ${TMP_CONTAINER} --link ${CONTAINER_NAME}:mysql \
            ${MYSQLIMAGE} /bin/sh -c "$EXPORT_COMMAND" > $BAK_FILE

    else
        eval $EXPORT_COMMAND > ${BAK_FILE}
    fi

    if [ $? == 0  ]
    then
        echo "dump success: ${BAK_FILE}" | tee -a ${LOGFILE}
	dding "备份成功: ${BAK_FILE}"
    else
        echo "dump fail" | tee -a ${LOGFILE}
	dding "mysql 备份失败,请注意 ${BAK_FILE}"
        echo "===================" | tee -a ${LOGFILE}
        exit 1
    fi

    COMMAND="mysql -hmysql -uroot -p${ROOT_PASSWORD} -e 'SHOW MASTER STATUS' "
    echo $COMMAND | tee -a ${LOGFILE};
    if [ "$USE_DOCKER" == "1" ]; then
        docker run -i --rm --name tmpmysql --link ${CONTAINER_NAME}:mysql \
            ${MYSQLIMAGE} /bin/sh -c "$COMMAND"
    else
        eval $COMMAND | tee -a ${LOGFILE}

    fi
    echo "===================" | tee -a ${LOGFILE}

    if [[ $_os == "Darwin"* ]] ; then
        sed -i '' 1,1d $BAK_FILE
    else
        sed -i 1,1d $BAK_FILE # Removes the password warning from the file
    fi

done
