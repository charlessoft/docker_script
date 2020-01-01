#!/bin/bash
source ./config.sh


function cmd_gitlab_restore() {
    docker exec -it ${GITLAB_CONTAINER_NAME} /bin/bash -c "/sbin/entrypoint.sh app:rake gitlab:backup:restore"

    sh stop_gitlab_service.sh
    sh start_gitlab_service.sh
}
cmd_gitlab_restore
#-v ${PWD}/repository.rb:/home/git/gitlab/lib/backup/repository.rb \
