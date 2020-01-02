#!/bin/bash
source ./config.sh
export THEME_NAME=./theme-name
# ======
: ${LAMBDA_ROOT:=${PWD}}

# Provide a variable with the location of this script.
#scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
#echo $scriptPath

# Source Scripting Utilities
# -----------------------------------
# These shared utilities provide many functions which are needed to provide
# the functionality in this boilerplate. This script will fail if they can
# not be found.
# -----------------------------------

#utilsLocation="${scriptPath}/lib/utils.sh" # Update this path to find the utilities.
utilsLocation="${LAMBDA_ROOT}/lib/utils.sh"
sharedFunction_location="${LAMBDA_ROOT}/lib/sharedFunctions.sh"

if [ -f "${utilsLocation}" ]; then
  source "${utilsLocation}"
  source "${sharedFunction_location}"
else
  echo "Please find the file util.sh and add a reference to it in this script. Exiting."
  echo 'utilsLocation:' ${utilsLocation}
  exit 1
fi
# ======

# link
# docker run --restart=always -d --name ${WORDPRESS_CONTAINER} \
# 	--env WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}\
#     -p ${WORDPRESS_PORT}:80 \
#     -v ${PWD}/wp-app:/var/www/html \
#     -v ${PWD}/theme-name/dux/:/var/www/html/wp-content/themes/dux \
#     -v ${PWD}/conf/php.conf.ini:/usr/local/etc/php/conf.d/conf.ini \
#     --link ${SQLDB_CONTAINER}:mysql \
#     ${WORDPRESS_IMAGE}


result=$(echo ${WORDPRESS_DB_HOST}| grep "127.0.0.1")
if [[ "$result" != "" ]]
then
    warning "不能使用127.0.0.1作为数据库链接地址"
    exit 0
fi


# 解压theme
if [ ! -d ./${THEME_NAME}/dux ]
then
    tar zxvf  ./${THEME_NAME}/dux.tar.gz  -C ${THEME_NAME}/
fi


docker run --restart=always -d \
    --name ${WORDPRESS_CONTAINER} \
    -e WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST} \
    -e WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD} \
    -e WORDPRESS_DB_USER=${WORDPRESS_DB_USER} \
    -e WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME} \
     -p ${WORDPRESS_PORT}:80 \
     -v ${PWD}/wp-app:/var/www/html \
     -v ${PWD}/theme-name/dux/:/var/www/html/wp-content/themes/dux \
     -v ${PWD}/conf/php.conf.ini:/usr/local/etc/php/conf.d/conf.ini \
     ${WORDPRESS_IMAGE}

check_runsuccess
success "启动成功,访问地址: http://127.0.0.1:${WORDPRESS_PORT}"
