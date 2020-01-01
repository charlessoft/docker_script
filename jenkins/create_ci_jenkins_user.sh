#!/bin/bash

# 调用
# sh create_ci_jenkins_user.sh jenkins pa44w0rd
source ./config.sh
: ${JENKINS_SSH_KEY_FOLDER:=${PWD}/ssh_key}

function creaet_ci_jenkins_user(){
	JENKINS_USER=$1
	USERPWD=$2
    USERS_WORKSPACE_HOME=$3



     if  [ ! -n "$USERS_WORKSPACE_HOME" ]
     then
         echo "USERS_WORKSPACE_HOME is null use home"
         USERS_WORKSPACE_HOME=/home
     else
         echo "USERS_WORKSPACE_HOME ${USERS_WORKSPACE_HOME}"
     fi

     if [ ! -d ${USERS_WORKSPACE_HOME} ]
     then
        mkdir ${USERS_WORKSPACE_HOME} -p
     fi

     `id ${JENKINS_USER} &>/dev/null`;
     if [ $? -eq 0 ]
     then
         echo "${JENKINS_USER} 已经存在用户"
         echo "需要手动增加互信,并且增加到docker 组"
         exit 1
     else
         echo "${JENKINS_USER} 添加用户成功"
         groupadd ci > /dev/null
         groupadd ${JENKINS_USER} > /dev/null
         useradd  -m -g ${JENKINS_USER}  ${JENKINS_USER} -G ci --home ${USERS_WORKSPACE_HOME}/${JENKINS_USER};
         echo "${USERPWD}" | passwd --stdin ${JENKINS_USER};
     fi

     if [ ! -f /etc/sudoers ]
     then
         echo "/etc/suders 文件不存在"
     else
         grep -n "${JENKINS_USER}.*ALL" /etc/sudoers >/dev/null 2>&1;
         if [ $? -ne 0 ]
         then
             #没写入到sudo表中
             sed -i '/root.*ALL/a'${JENKINS_USER}'    ALL=(ALL)   NOPASSWD:ALL' /etc/sudoers
         fi

     fi

     su - ${JENKINS_USER} -c "ssh-keygen -t rsa -N '' -f ${USERS_WORKSPACE_HOME}/${JENKINS_USER}/.ssh/id_rsa -q -b 2048 -C 'jenkins@demo.cn'"

     cat ${JENKINS_SSH_KEY_FOLDER}/id_rsa.pub >> ${USERS_WORKSPACE_HOME}/${JENKINS_USER}/.ssh/authorized_keys
     chown ${JENKINS_USER}:${JENKINS_USER} ${USERS_WORKSPACE_HOME}/${JENKINS_USER}/.ssh/authorized_keys
     chmod 600 ${USERS_WORKSPACE_HOME}/${JENKINS_USER}/.ssh/authorized_keys

     groupadd docker
     gpasswd -a ${JENKINS_USER} docker




}

function main(){
    if [ $# != 2 ] ; then
    echo "USAGE: sh create_ci_jenkins_user.sh jenkins pa44w0rd"
    exit 1;
else
    creaet_ci_jenkins_user $@

    fi

}

#creaet_ci_jenkins_user $@
echo ${JENKINS_USER}
echo ${JENKINS_PASSWORD}
echo ${JENKINS_URL}
main jenkins pa44w0rd
