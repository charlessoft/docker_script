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
# Export dump
EXPORT_COMMAND="exec mysqldump --databases $BACK_DATABASE_NAME -uroot -p$ROOT_PASSWORD"
# docker-compose exec db sh -c "$EXPORT_COMMAND" > $BAK_FILE
docker exec -it mysql /bin/bash -c "$EXPORT_COMMAND" > $BAK_FILE
if [ $? == 0  ]
then
    echo "dump success"
fi

if [[ $_os == "Darwin"* ]] ; then
  sed -i '' 1,1d $BAK_FILE
else
  sed -i 1,1d $BAK_FILE # Removes the password warning from the file
fi

