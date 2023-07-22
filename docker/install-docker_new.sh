#!/usr/bin/env bash
source ./config.sh

# Download docker
echo "download: ${DOCKER_PACKAGE_URL}"
echo "download: ${DOCKER_COMPOSE_URL}"
wget -N -c $DOCKER_PACKAGE_URL --no-check-certificate -O ${DOCKER_PACKAGE}
wget -N -c $DOCKER_COMPOSE_URL --no-check-certificate -O ${DOCKER_COMPOSE}
if [ $? -eq 0 ]; then
    echo "download docker files succeed!"
else
    echo "download docker files fail!"
    exit 1
fi


# Running in target host environment.
SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)

: ${DOCKER_PACKAGE:=docker-18.06.0-ce.tar.gz}
: ${DOCKER_COMPOSE_PACKAGE:=docker-compose-1.21.2-Linux-x86_64.tar.gz}
# : ${DOCKER_ACCESS_PORT:="-H unix:///var/run/docker.sock -H 0.0.0.0:2375"}
: ${DOCKER_ACCESS_PORT:="-H unix:///var/run/docker.sock "}
: ${DOCKER_DATA_ROOT:=/opt/docker/data}
: ${PRIVATE_REGISTRY:=127.0.0.1}
: ${REGISTRY_PORT:=5000}
: ${REGISTRY_MIRROR:=https://mytfd7zc.mirror.aliyuncs.com}

if [ "$PRIVATE_REGISTRY" != "" ]; then
    INSECURE_REGISTRY="--insecure-registry $PRIVATE_REGISTRY:$REGISTRY_PORT"
fi

if [ "$REGISTRY_MIRROR" != "" ]; then
    DOCKER_REGISTRY_MIRROR="--registry-mirror $REGISTRY_MIRROR"
fi

echo "DOCKER_PACKAGE:" $DOCKER_PACKAGE
echo "DOCKER_COMPOSE_PACKAGE:" $DOCKER_COMPOSE_PACKAGE
echo "DOCKER_ACCESS_PORT:" $DOCKER_ACCESS_PORT
echo "DOCKER_DATA_ROOT:" $DOCKER_DATA_ROOT
echo "PRIVATE_REGISTRY:" $PRIVATE_REGISTRY
echo "REGISTRY_PORT:" $REGISTRY_PORT
echo "REGISTRY_MIRROR:" $REGISTRY_MIRROR
echo

sudo tar xvf ${SCRIPT_PATH}/${DOCKER_PACKAGE} --strip-components 1  -C /usr/local/bin/
# sudo tar xvf ${SCRIPT_PATH}/${DOCKER_COMPOSE_PACKAGE} -C /usr/local/bin/
# sudo ln -sf /usr/local/bin/docker-compose-1.21.2-Linux-x86_64 /usr/local/bin/docker-compose
sudo chmod +x docker-compose-Linux-x86_64
sudo cp docker-compose-Linux-x86_64 /usr/local/bin/
sudo ln -sf /usr/local/bin/docker-compose-Linux-x86_64 /usr/local/bin/docker-compose

sudo groupadd docker
#usermode -aG docker $USER
sudo gpasswd -a $USER docker

sudo tee /etc/systemd/system/dockerd.service <<-EOF
[Unit]
Description=Dockerd
#After=network-online.target firewalld.service
Wants=network-online.target

[Service]
#ExecStart=/usr/local/bin/dockerd ${DOCKER_ACCESS_PORT}
ExecStart=/usr/local/bin/dockerd ${DOCKER_ACCESS_PORT}
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
TimeoutStartSec=0
Delegate=yes
KillMode=process
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target

EOF

sudo systemctl enable dockerd.service
sudo systemctl restart dockerd.service

#mkdir -p /etc/docker && \
    #echo '{"registry-mirrors": ["http://'${PRIVATE_REGISTRY}'"], "insecure-registries" : [ "'${PRIVATE_REGISTRY}'"]  }' > /etc/docker/daemon.json
mkdir -p /etc/docker && \
tee /etc/docker/daemon.json <<-EOF
{
  "data-root": "${DOCKER_DATA_ROOT}",
  "insecure-registries": [
    "${PRIVATE_REGISTRY}:${REGISTRY_PORT}"
  ],
"log-driver": "json-file",
  "log-opts": {
    "max-size": "200m",
    "max-file": "3"
  },
  "registry-mirrors": [
    "${REGISTRY_MIRROR}"
  ]
}
EOF

sudo service dockerd restart

