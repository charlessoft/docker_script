#!/bin/bash

DOCKER_PACKAGE_URL=https://download.docker.com/linux/static/stable/x86_64/docker-18.06.3-ce.tgz

# https://github.com/docker/compose/releases/download/1.21.2/docker-compose-Linux-x86_64
DOCKER_COMPOSE_URL="https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m)"

export DOCKER_PACKAGE=${DOCKER_PACKAGE_URL##*/}
export DOCKER_COMPOSE=${DOCKER_COMPOSE_URL##*/}
echo $DOCKER_PACKAGE
echo $DOCKER_COMPOSE

