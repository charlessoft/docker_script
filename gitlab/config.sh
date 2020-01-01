
# require

# gitlab ip
GITLAB_HOST_IP=106.14.227.239

# root path
GITLAB_ROOT=/opt/lambda/gitlab

# volume
DOCKER_GITLAB_VOLUME=${GITLAB_ROOT}/gitlab_data

# backup folder
DOCKER_GITLAB_BACKUP_FOLDER=${GITLAB_ROOT}/gitlab_backups


# =============================================
# option

# docker images
GITLAB_REDIS_FILE=sameersbn/redis:latest
GITLAB_POSTGRESQL_FILE=sameersbn/postgresql:9.4-23
GITLAB_GITLAB_FILE=sameersbn/gitlab:11.5.3

# gitlab http port
GITLAB_PORT=10000
# gitlab ssh port
GITLAB_SSH_PORT=10023


# gitlab db user password
GITLAB_DB_USER=gitlab
GITLAB_DB_PASS=password


# root(admin) password, default 5iveL!fe
GITLAB_ROOT_PASSWORD=pa44w0rd

# 容器名
GITLAB_CONTAINER_NAME=gitlab
GITLAB_POSTGRESQL_CONTAINER_NAME=postgresql-gitlab
GITLAB_REDIS_CONTAINER_NAME=gitlab-redis
