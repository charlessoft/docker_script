#!/bin/bash
service dockerd stop
## rm -fr temp file
rm -fr /usr/local/bin/docker
rm -fr /usr/local/bin/docker-containerd
rm -fr /usr/local/bin/docker-containerd-ctr
rm -fr /usr/local/bin/docker-containerd-shim
rm -fr /usr/local/bin/docker-init
rm -fr /usr/local/bin/docker-proxy
rm -fr /usr/local/bin/docker-runc
rm -fr /usr/local/bin/dockerd
rm -fr /usr/local/bin/docker-compose

## rm -fr service
rm -fr /etc/systemd/system/dockerd.service
