#!/bin/bash
source ./config.sh

if [ $# != 1 ]
then
    echo "eg: sh createdb.sh xxx"
    exit 0
fi
database=$1
TMPFILE=/tmp/cmd.txt
CREATE_COMMAND="CREATE DATABASE IF NOT EXISTS ${database} DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci;"
echo ${CREATE_COMMAND} > ${TMPFILE}
# docker cp ${TMPFILE} ${CONTAINER_NAME}:/tmp
COMMAND="mysql -h ${MYSQL_IP} -uroot -p${ROOT_PASSWORD} < ${TMPFILE}"
echo $COMMAND
eval $COMMAND  | tee -a
if [ $? -eq 0 ]; then
    echo "创建数据库${database}成功:)"
else
    echo "创建数据库${database}失败:("

fi

# docker exec -it ${CONTAINER_NAME} /bin/bash -c "$COMMAND"

# docker run -it --rm --name createdb_tmpmysql -v ${TMPFILE}:/tmp/cmd.txt ${MYSQLIMAGE} /bin/sh -c "$COMMAND"
