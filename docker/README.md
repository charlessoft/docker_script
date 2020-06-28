# 安装docker

## 下载静态包
修改config.sh后,执行安装脚本自动会下载
wget https://download.docker.com/linux/static/stable/x86_64/docker-18.06.0-ce.tgz
wget https://github.com/docker/compose/releases/download/1.21.2/docker-compose-Linux-x86_64

wget https://download.docker.com/linux/static/stable/x86_64/docker-19.03.9.tgz
curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

## 安装
```
bash  install-docker_new.sh
```
