#!/bin/bash

source ./config.sh
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

if [ -f "${utilsLocation}" ]; then
  source "${utilsLocation}"
else
  echo "Please find the file util.sh and add a reference to it in this script. Exiting."
  echo 'utilsLocation:' ${utilsLocation}
  exit 1
fi
# ======


adminpwwdLocation=${DOCKER_JENKINS_VOLUME}/jenkins_home/secrets/initialAdminPassword
mkdir -p $DOCKER_JENKINS_VOLUME/jenkins_home
#mkdir -p $DOCKER_JENKINS_VOLUME/jenkins_backups
mkdir -p ${DOCKER_JENKINS_BACKUP_FOLDER}
#cp -r /root/.ssh $DOCKER_JENKINS_VOLUME/jenkins_home
#cp -r ${PWD}/.ssh  $DOCKER_JENKINS_VOLUME/jenkins_home
cp -r ${PWD}/ssh_key $DOCKER_JENKINS_VOLUME/jenkins_home/.ssh
chown -R 1000:1000 $DOCKER_JENKINS_VOLUME/jenkins_home
chown -R 1000:1000 ${DOCKER_JENKINS_BACKUP_FOLDER}

docker run --restart=always -d --name ${DOCKER_CONTAINER_NAME} -p 9090:8080 -p 50000:50000 \
    -v $DOCKER_JENKINS_VOLUME/jenkins_home:/var/jenkins_home \
    -v ${DOCKER_JENKINS_BACKUP_FOLDER}:/tmp/jenkins_backups \
    -v /etc/hosts:/etc/hosts \
    -e JAVA_OPTS=-Dorg.apache.commons.jelly.tags.fmt.timeZone=Asia/Shanghai \
    ${JENKINS_FILE}


if [ "$?" -eq '0' ];then
    if [ -f '.first'  ];then
        success 'jenkins service'
    else
            while true
            do
                if [ -f ${adminpwwdLocation} ];
                then
                    # 暂停5秒,jenkins服务还未准备好,
                    info "install jenkins plugins..."
                    sleep 10
                    # 首次运行,输入安装密码

                    sh install_jenkins_plugins.sh
                    success  "install plugins"
                    success  "please open http://${JENKINS_URL} and enter init admin password"
                    echo '-----'
                    pwd=`cat ${DOCKER_JENKINS_VOLUME}/jenkins_home/secrets/initialAdminPassword`
                    echo $pwd
                    echo '-----'
                    echo $pwd > .first
                    break
                else
                    info  "${DOCKER_CONTAINER_NAME} init.. wait for a moment.."
                    sleep 3
                fi
            done


        fi
    else
        error "jenkins service"

    fi
