# nginx  


### nginx 静态资源服务器
静态资源服务器


#### 服务架构

单机容器化部署，应用目录/home/basin/nginx/，数据目录/opt/lambda/nginx/。  


#### 安装

```
需要在config.sh 中配置数据存储路径,密码(可选)
sh install_docker_nginx.sh
```

#### 启动

```
sh start_nginx_service.sh
```

#### 停止

```
sh stop_nginx_service.sh
```


#### 基础配置

#### 默认端口

| 服务 | 端口号 |
| --- | --- |
| nginx | 8081 |



#### 数据安全

持久化数据在/opt/lambda/nginx_data/，配置数据在/home/basin/nginx/，

#### 数据导出

暂无

#### 数据导入

暂无


#### 数据备份

暂无

#### 数据还原

暂无

#### 服务接口

通过访问 http://http_server.basin.site:8081

#### 服务工具

暂无

#### 关键性能指标

暂无

