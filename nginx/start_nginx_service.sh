#!/bin/bash
source ./config.sh
# ======
: ${LAMBDA_ROOT:=${PWD}}
# ======

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

if [ -f "${utilsLocation}" ]; then
  source "${utilsLocation}"
else
  echo "Please find the file util.sh and add a reference to it in this script. Exiting."
  echo 'utilsLocation:' ${utilsLocation}
  exit 1
fi

if [ "${PASSWORD}" != "" -a "${USER}" != "" ]; then
    pass=`openssl passwd -crypt ${PASSWORD}`
    HTPASSWD=$USER:$pass
    echo $HTPASSWD > ./htpasswd
    echo "设置密码"
    sed -in-place -e 's/^#\(.*auth_basic.*\)/\1/' default.conf
else
    echo "no password"
    sed -in-place -e "s/\(^.*auth_basic.*$\)/#\1/" default.conf
fi

docker run --restart=always --name http_static_server \
    -v ${PWD}/default.conf:/etc/nginx/conf.d/default.conf \
    -v ${DOCKER_NGINX_VOLUME}:/usr/share/nginx/html:ro  -d  \
    -v ${PWD}/htpasswd:/usr/local/nginx/conf/vhost/htpasswd \
    -p ${PORT}:80 \
    -e TZ=Asia/Shanghai \
    ${DOCKER_NGINX_FILE}

success "start nginx success"
