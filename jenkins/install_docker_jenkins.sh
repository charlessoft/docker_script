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
    jq \
    git \
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
    docker pull ${JENKINS_FILE}
    if [ $? -eq 0  ]; then
        success "docker pull ${JENKINS_FILE} "
    else
        error "docker pull ${JENKINS_FILE} "
    fi
}

function create_folder(){

    mkdir -p ${DOCKER_JENKINS_VOLUME}
    if [ $? -eq 0 ]; then
        echo "mkdir ${DOCKER_JENKINS_VOLUME} success "
        success "mkdir ${DOCKER_JENKINS_VOLUME} success "
    else
        exit 1
    fi

    mkdir -p ${DOCKER_JENKINS_BACKUP_FOLDER}
    if [ $? -eq 0 ]; then
        success "mkdir ${DOCKER_JENKINS_BACKUP_FOLDER} success "
    else
        exit 1
    fi



}

function init_jenkins_ssh_key(){

    echo "mkdir -p ${JENKINS_SSH_KEY_FOLDER}"
    mkdir -p ${JENKINS_SSH_KEY_FOLDER}
    if [ -f "${JENKINS_SSH_KEY_FOLDER}/id_rsa" ]; then
        warning "exist ssh_key continue"
    else
        ssh-keygen -t rsa -N "" -f ${JENKINS_SSH_KEY_FOLDER}/id_rsa -q -b 2048 -C "jenkins@jenkins.cn"
        succes "init jenins ssh-key"
    fi

}

check_depends_cmd
create_folder
init_jenkins_ssh_key
pull_imaegs

