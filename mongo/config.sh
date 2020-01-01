#!/bin/bash
# private registry
: ${PRIVATE_REGISTRY:=registry.basin.site:8050}

# mongodb admin db user password
: ${MONGO_INITDB_ROOT_USERNAME:=root}
: ${MONGO_INITDB_ROOT_PASSWORD:=admin}
: ${MONGO_DATA_DIR:=/opt/lambda/mongo_data/}

# mongo-express webui login user and password
: ${ME_CONFIG_BASICAUTH_USERNAME:=admin}
: ${ME_CONFIG_BASICAUTH_PASSWORD:=pa44w0rd}

export PRIVATE_REGISTRY
export MONGO_INITDB_ROOT_USERNAME
export MONGO_INITDB_ROOT_PASSWORD
export ME_CONFIG_BASICAUTH_USERNAME
export ME_CONFIG_BASICAUTH_PASSWORD
export MONGO_DATA_DIR
