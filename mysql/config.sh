#!/bin/bash

MYSQL_ROOT=${PWD}

MYSQLIMAGE=mysql:5.7.23
PORT=3306
DOCKER_MYSQL_BACKUP_FOLDER=${MYSQL_ROOT}/backups

# data folder
DOCKER_MYSQL_VOLUME=${MYSQL_ROOT}/mysql/data

# mysql config

DOCKER_MYSQL_CONFIG=${MYSQL_ROOT}/conf

# 数据库密码,
ROOT_PASSWORD=root

CONTAINER_NAME=mysql



# for backup.sh
# 1. 需要制定导出的备份的数据库名字.
BACK_DATABSE_NAME=xxxxx
