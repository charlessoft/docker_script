#!/bin/bash

# private registry
: ${PRIVATE_REGISTRY:=registry.basin.site:8050}

# password
: ${PASSWORD:=foo}
: ${REDIS_DATA_DIR:=/tmp/redis_data/}


# login user and password
: ${HTTP_USER:=admin}
: ${HTTP_PASSWORD:=admin}


export PASSWORD
export REDIS_DATA_DIR
export PRIVATE_REGISTRY
export HTTP_USER
export HTTP_PASSWORD
