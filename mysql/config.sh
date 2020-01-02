#!/bin/bash

# ===== mysql 配置=====#

# 根路径
MYSQL_ROOT=${PWD}

# mysql 镜像
MYSQLIMAGE=mysql:5.7.23

# 数据库密码
ROOT_PASSWORD=root

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
BACK_DATABSE_NAME=xxxxx

# ===== mysql 配置=====#
