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

docker run --restart=always \
    --name ${GITLAB_REDIS_CONTAINER_NAME} -d \
    --volume $DOCKER_GITLAB_VOLUME/redis:/var/lib/redis \
    ${GITLAB_REDIS_FILE}
    #sameersbn/redis:latest


docker run --restart=always \
    --name ${GITLAB_POSTGRESQL_CONTAINER_NAME} -d \
    --env 'DB_NAME=gitlabhq_production' \
    --env "DB_USER=${GITLAB_DB_USER}" \
    --env "DB_PASS=${GITLAB_DB_PASS}" \
    --env 'DB_EXTENSION=pg_trgm' \
    --env 'DB_PORT=5432' \
    --volume $DOCKER_GITLAB_VOLUME/postgresql:/var/lib/postgresql \
    ${GITLAB_POSTGRESQL_FILE}
    #sameersbn/postgresql:9.4-23
    #--publish 5431:5432 \

docker run --restart=always \
    --name ${GITLAB_CONTAINER_NAME} -d \
    --link ${GITLAB_POSTGRESQL_CONTAINER_NAME}:postgresql \
    --link ${GITLAB_REDIS_CONTAINER_NAME}:redisio \
    --publish ${GITLAB_SSH_PORT}:22 \
    --publish ${GITLAB_PORT}:80 \
    -v /etc/hosts:/etc/hosts \
    --env "GITLAB_ROOT_PASSWORD=${GITLAB_ROOT_PASSWORD}" \
    --env "GITLAB_HOST=${GITLAB_HOST_IP}" \
    --env "TZ=Asia/Shanghai" \
    --env "GITLAB_TIMEZONE=Asia/Shanghai" \
    --env "GITALY_TOKEN=abc123secret" \
    --env "GITLAB_PORT=${GITLAB_PORT}" \
    --env "GITLAB_SSH_PORT=${GITLAB_SSH_PORT}" \
    --env 'GITLAB_SECRETS_DB_KEY_BASE=long-and-random-alpha-numeric-string' \
    --env 'GITLAB_SECRETS_OTP_KEY_BASE=long-and-random-alpha-numeric-string' \
    --env 'GITLAB_SECRETS_SECRET_KEY_BASE=long-and-random-alpha-numeric-string' \
    --env "GITLAB_BACKUP_SCHEDULE=daily" \
    --env "GITLAB_BACKUP_TIME=01:00" \
    --env "GITLAB_BACKUP_EXPIRY=2592000" \
    --volume $DOCKER_GITLAB_VOLUME/gitlab:/home/git/data \
    --volume ${DOCKER_GITLAB_BACKUP_FOLDER}:/home/git/data/backups \
    ${GITLAB_GITLAB_FILE}
    #sameersbn/gitlab:11.3.5


if [ "$?" -eq '0' ];then
        success 'start gitlab service'
        success  "please open http://${GITLAB_HOST_IP}:${GITLAB_PORT}"
    else
        error "start gitlab service fail"
fi
