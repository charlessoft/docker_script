#!/bin/bash
#NAMESPACE=$1
#echo "${NAMESPACE}"
#echo '====='

namespace=( \
    tianguicheng \
    jenkins-test \
    chiruibao \
    newzhidao \
    songlihua \
    beidaml \
    eos \
    yq \
    csp \
    lab \
    udb \
    items \
    chenjianghai \
    bidspy \
    chenqian \
    basin \
    linzhao \
    uukuguy \
    )

for data in ${namespace[@]}
do
    sed -e "s/NAMESPACE_TMP/$data/g" ./namespace.tmp > 1.sh
    sh 1.sh
done

