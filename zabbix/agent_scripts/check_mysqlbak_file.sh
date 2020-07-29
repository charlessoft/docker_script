#!/bin/bash
MYSQL_BACKUP_FOLDER=/home/portal/backup/mysql
MYSQL_BACKUP_CONFIG=/home/portal/apps/scripts/mysql_0.12/config.sh
source ${MYSQL_BACKUP_CONFIG}
BAK_DATE=`date "+%Y-%m-%d"`

MYSQL_BACKUP=${MYSQL_BACKUP_FOLDER}/${BAK_DATE}
ret=`find ${MYSQL_BACKUP} -name "*.sql"|wc -l`
NEED_BACKUP_COUNT=`echo ${BACK_DATABASE_NAME[@]} |wc -w`
if [ "$ret" -ne "$NEED_BACKUP_COUNT" ]
then
	echo "备份失败"
	exit 1
else
	echo "ok"
	exit 0
fi

