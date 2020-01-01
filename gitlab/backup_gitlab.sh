#!/bin/bash
source ./config.sh

# backup
function cmd_gitlab_backup(){
    docker exec -it ${GITLAB_CONTAINER_NAME} /bin/bash -c "/sbin/entrypoint.sh app:rake gitlab:backup:create"
    sh stop_gitlab_service.sh
    sh start_gitlab_service.sh

}

function create_folder(){
    mkdir -p ${DOCKER_GITLAB_BACKUP_FOLDER}

    if [ $? -eq 0 ]; then
        echo "mkdir ${DOCKER_GITLAB_VOLUME} succeed"
    else
        echo "failed"
        exit 1
    fi

}
create_folder
cmd_gitlab_backup
