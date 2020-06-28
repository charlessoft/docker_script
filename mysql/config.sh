#!/bin/bash

# ===== mysql 配置=====#

# 根路径
MYSQL_ROOT=${PWD}

# mysql ip
MYSQL_IP=47.114.144.200

# mysql 镜像
MYSQLIMAGE=mysql:5.7.23

# 数据库密码
ROOT_PASSWORD=pa44w0rd

# 容器名字
CONTAINER_NAME=mysql

# 对外端口
PORT=3306

# 数据库备份路径
DOCKER_MYSQL_BACKUP_FOLDER=${MYSQL_ROOT}/backups

# 数据库挂载路径
DOCKER_MYSQL_VOLUME=${MYSQL_ROOT}/mysql/data

# mysql 配置信息
DOCKER_MYSQL_CONFIG=${MYSQL_ROOT}/conf

# for backup.sh
# 1. 需要制定导出的备份的数据库名字.
BACK_DATABASE_NAME=( \
    wordpress \
    xxx \
)
# 2. 全部导出
#BACK_DATABASE_NAME=ALL

# ===== mysql 配置=====#
