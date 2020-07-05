#!/bin/bash

# ===== mysql 配置=====#

# 根路径
MYSQL_ROOT=${PWD}

# mysql ip
MYSQL_IP=10.203.27.255

# mysql 镜像
MYSQLIMAGE=mysql:5.7.23

# 数据库密码
ROOT_PASSWORD=pa44w0rd

# 容器名字
CONTAINER_NAME=mysql

# 对外端口
PORT=3306

# 数据库备份路径
MYSQL_BACKUP_FOLDER=${MYSQL_ROOT}/backups

# 数据库挂载路径
DOCKER_MYSQL_VOLUME=${MYSQL_ROOT}/mysql/data

# mysql 配置信息
DOCKER_MYSQL_CONFIG=${MYSQL_ROOT}/conf

# for backup.sh
# 1. 需要制定导出的备份的数据库名字.
BACK_DATABASE_NAME=( \
    saas \
)
# 2. 全部导出
#BACK_DATABASE_NAME=ALL


# 是否使用docker 方式,
# 0 不使用,使用本地mysql命令
# 1 使用
USE_DOKER=0

LOG_PATH=${PWD}/logs

# ===== mysql 配置=====#
