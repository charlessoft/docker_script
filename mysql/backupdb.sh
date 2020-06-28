#!/bin/bash
source ./config.sh
_os="`uname`"
_now=$(date +"%m_%d_%Y")

: ${BACK_FOLDER:=${PWD}/bak}
: ${BAK_FILE:=${BACK_FOLDER}/${BACK_DATABASE_NAME}_${_now}_bak.sql}
: ${CONTAINER_NAME:=mysql}
: ${BACK_DATABASE_NAME=wordpress}
if [ $# != 1 ]
then
    echo "eg: sh backup.sh wordpress"
    echo "use default config: ${BACK_DATABASE_NAME}"
else
    BACK_DATABASE_NAME=$1
fi

mkdir -p ${BACK_FOLDER}

for DBNAME in ${BACK_DATABASE_NAME[@]}
do
    echo $DBNAME
    # Export dump
    TMP_CONTAINER=epxport_tmpmysq;
    EXPORT_COMMAND="mysqldump --host ${MYSQL_IP} --databases ${BACK_DATABASE_NAME} -uroot -p$ROOT_PASSWORD"
    # docker-compose exec db sh -c "$EXPORT_COMMAND" > $BAK_FILE
    #docker exec -it mysql /bin/bash -c "$EXPORT_COMMAND" > $BAK_FILE
    docker ps -a |grep ${TMP_CONTAINER}
    if [ $? -eq 0 ]; then
        echo "容器存在${TMP_CONTANER},停止导入数据库,请联系管理员"
        exit 1
    else
        echo "容器不存在在,开始创建容器${TMP_CONTANER},导入数据"
    fi

    docker run -it --rm --name ${TMP_CONTAINER} \
        ${MYSQLIMAGE} /bin/sh -c "$EXPORT_COMMAND" > $BAK_FILE


    if [ $? == 0  ]
    then
        echo "dump success: ${BAK_FILE}"
    else
        echo "dump fail"
        exit 1
    fi

    if [[ $_os == "Darwin"* ]] ; then
        sed -i '' 1,1d $BAK_FILE
    else
        sed -i 1,1d $BAK_FILE # Removes the password warning from the file
    fi

done
