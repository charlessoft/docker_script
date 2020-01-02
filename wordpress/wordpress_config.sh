#!/bin/bash

# ===== wordpress 配置 =====#

# wordpress 镜像
WORDPRESS_IMAGE=wordpress

# wordpress 容器名
WORDPRESS_CONTAINER=wordpress

# wordpress 对外服务端口
WORDPRESS_PORT=8080


# 数据库容器名字, 单机部署做link用
# SQLDB_CONTAINER=mysql

# 数据库ip
WORDPRESS_DB_HOST=127.0.0.1:3306

# 数据库root 密码
WORDPRESS_DB_PASSWORD=root

# 用户名
WORDPRESS_DB_USER=root

# wordpress数据库名字
WORDPRESS_DB_NAME=wordpress

# ===== wordpress 配置 =====#
