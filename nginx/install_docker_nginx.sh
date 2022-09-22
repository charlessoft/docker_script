#!/bin/bash
source ./config.sh

# ======
: ${LAMBDA_ROOT:=${PWD}}
: ${JENKINS_SSH_KEY_FOLDER:=${PWD}/ssh_key}
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


CMD_LIST=( \
    )


#---------------
# 检测是否安装依赖命令行
#---------------
function check_depends_cmd(){
    for CMD in ${CMD_LIST[@]}
    do
        which ${CMD} > /dev/null 2>&1
        if [ $? -eq 0 ]
        then
            success "check ${CMD}"
        else
            echo "${CMD} no such file"
            exit 1
        fi

    done

}


function pull_imaegs(){
    # ${HARBORCMD} pull sameersbn/gitlab:11.3.5 sameersbn/gitlab:11.3.5
    # ${HARBORCMD} pull sameersbn/redis:latest sameersbn/redis:latest
    # ${HARBORCMD} pull sameersbn/postgresql:9.4-23 sameersbn/postgresql:9.4-23
    docker pull ${DOCKER_NGINX_FILE}
    if [ $? -eq 0  ]; then
        success "docker pull ${DOCKER_NGINX_FILE} "
    else
        error "docker pull ${DOCKER_NGINX_FILE} "
    fi
}


check_depends_cmd
pull_imaegs

