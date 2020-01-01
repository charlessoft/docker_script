#!/bin/bash
source ./config.sh

function gettimestamp() {
     echo `date +%s`

 }

function cmd_jenkins_backup() {
	mkdir -p ${DOCKER_JENKINS_BACKUP_FOLDER}
	echo "停止jenkins..."
    sh stop_jenkins_service.sh
	cd $DOCKER_JENKINS_VOLUME

	echo "当前路径:" ${PWD}
    timespamp=$(gettimestamp)
    backup_file=jenkins_home_${timespamp}.tar.gz
    echo "备份文件名:" ${backup_file}


    # tar zcvf ${backup_file} jenkins_home --exclude jobs
    tar zcvf ${backup_file} jenkins_home --exclude jobs/*.log --exclude caches --exclude workspace --exclude archive
    echo "保存备份文件到:" ${DOCKER_JENKINS_BACKUP_FOLDER}
    mv ${backup_file} ${DOCKER_JENKINS_BACKUP_FOLDER}
    cd -
    sh start_jenkins_service.sh
}

cmd_jenkins_backup
