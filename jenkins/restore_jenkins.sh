#!/bin/bash

source ./config.sh

function cmd_docker_jenkins_restore_list(){
	echo "cmd_docker_jenkins_restore_list"
	echo  ${DOCKER_JENKINS_BACKUP_FOLDER}
	cd ${DOCKER_JENKINS_BACKUP_FOLDER}
	ls -l --color=auto -rth *.tar.gz
	cd - >/dev/null

}

function cmd_docker_jenkins_restore(){
	restore_file=$1

	if [ x"$restore_file" == x"" ]
	then
		# echo.Red "restore_file is null"
		read -p "please input backfilename：" backfilename
		# echo $backfilename
		echo "backfilepath:" ${DOCKER_JENKINS_BACKUP_FOLDER}/$backfilename
		if [ ! -f ${DOCKER_JENKINS_BACKUP_FOLDER}/$backfilename ]
		then
			echo "Error: No such file or directory, $backfilename"
			exit 1
		else
			echo "begin restore $backfilename"
			mkdir -p ${DOCKER_JENKINS_VOLUME}
			tar zxvf ${DOCKER_JENKINS_BACKUP_FOLDER}/$backfilename -C ${DOCKER_JENKINS_VOLUME}
            sh stop_jenkins_service.sh
            sh start_jenkins_service.sh
		fi

	else
		tar zxvf ${DOCKER_JENKINS_BACKUP_FOLDER}/$backfilename -C ${DOCKER_JENKINS_VOLUME}

	fi

}
cmd_docker_jenkins_restore_list
cmd_docker_jenkins_restore
