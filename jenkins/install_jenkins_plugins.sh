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


plugs=( \
    dingding-notifications \
	workflow-aggregator \
	subversion \
    localization-zh-cn \
    ldap \
    pam-auth \
    matrix-auth \
    pipeline-stage-view \
    pipeline-github-lib \
    github-branch-source \
    timestamper \
    credentials-binding \
    build-timeout \
    cloudbees-folder \
    antisamy-markup-formatter \
    blueocean \
    ansicolor \
    gradle \
    ant \
    git-parameter \
    gitlab-plugin
    golang \
    gitlab-oauth \
    http_request \
    publish-over-ssh \
    ssh-slaves \
    ws-cleanup \
    sonar \
    sonargraph-plugin \
    sonargraph-integration \
    )

if [ x"${JENKINS_PASSWORD}" == x'' ];then
JENKINS_PASSWORD=`cat ${DOCKER_JENKINS_VOLUME}/jenkins_home/secrets/initialAdminPassword`
fi

echo "curl --user $JENKINS_USER:$JENKINS_PASSWORD $JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)"

CRUMB=$(curl --user $JENKINS_USER:$JENKINS_PASSWORD \
    $JENKINS_URL/crumbIssuer/api/xml?xpath=concat\(//crumbRequestField,%22:%22,//crumb\))

echo "===="
echo ${CRUMB}
if  [ ${#CRUMB} -gt 50 ]; then
    echo 'get curmb fail, you can run sh install_jenkins_plugins.sh'
    exit 1
else
    echo "get curmb success"
fi
echo "===="
for plug in ${plugs[@]}
do
    info "install ${plug}"

    curl -v -XPOST --user $JENKINS_USER:$JENKINS_PASSWORD -H "$CRUMB" http://${JENKINS_USER}:${JENKINS_PASSWORD}@${JENKINS_URL}/pluginManager/installNecessaryPlugins -d "<install plugin=\"${plug}@current\" />"
    #exit 1
done
