#!/bin/bash
source ./config.sh
_os="`uname`"
_now=$(date +"%m_%d_%Y")
# _file="wp-data/data_$_now.sql"
: ${BACK_FOLDER:=${PWD}/bak}
: ${BAK_FILE:=${BACK_FOLDER}/bak_${_now}.sql}
: ${CONTAINER_NAME:=mysql}

mkdir -p ${BACK_FOLDER}
# Export dump
EXPORT_COMMAND="exec mysqldump $BACK_DATABASE_NAME -uroot -p$ROOT_PASSWORD"
# docker-compose exec db sh -c "$EXPORT_COMMAND" > $BAK_FILE
docker exec -it mysql /bin/bash -c "$EXPORT_COMMAND" > $BAK_FILE

if [[ $_os == "Darwin"* ]] ; then
  sed -i '' 1,1d $BAK_FILE
else
  sed -i 1,1d $BAK_FILE # Removes the password warning from the file
fi
