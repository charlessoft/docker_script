
# root path
JENKINS_ROOT=/opt/lambda/jenkins/

# volume
DOCKER_JENKINS_VOLUME=${JENKINS_ROOT}/jenkinsdata/

# backup folder
DOCKER_JENKINS_BACKUP_FOLDER=${JENKINS_ROOT}/jenkinsdata_backups/


# 登录jenkins账号密码
JENKINS_USER=admin
# 如果为空,默认读取 initadminpassword下初始密码
JENKINS_PASSWORD=
JENKINS_URL=localhost:9090

# option
#JENKINS_FILE=jenkinsci/jenkins:lts
#JENKINS_FILE=jenkins/jenkins:2.153
JENKINS_FILE=jenkinsci/jenkins:2.153

DOCKER_CONTAINER_NAME=jenkins

export DOCKER_JENKINS_VOLUME
export DOCKER_JENKINS_BACKUP_FOLDER
export JENKINS_FILE
export JENKINS_USER
export JENKINS_PASSWORD
export JENKINS_URL
export DOCKER_CONTAINER_NAME
