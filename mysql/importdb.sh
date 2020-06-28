#!/bin/bash
source ./config.sh

if [ $# != 1 ]
then
    echo "eg: sh import.sh xx/bak_xx.sql"
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



docker run -it --rm --name importdb_tmpmysql -v ${fullfile}:/tmp/bak.sql ${MYSQLIMAGE} /bin/sh -c "$COMMAND"
echo 运行结果: $?
