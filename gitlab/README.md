
### gitlab

提供Lambda平台自身的离线安装部署能力，及平台内应用服务的持续部署能力。
假设服务运行主机gitlab.basin.site。

#### 服务架构
单机容器化部署，应用目录/home/basin/gitlab/，数据目录/opt/lambda/gitlab_data/。启动脚本`sh start_gitlab_service.sh`，访问端口10000。
默认管理员账号:root,密码:pa4****d


### 默认端口

| 服务 | 端口号 |
| --- | --- |
| gitlab-http | 10000 |
| gitlab-ssh | 10023 |


## 安装
```
需要在config.sh 中配置数据存储路径和备份路径
sh install_docker_gitlab.sh
```

## 启动
```
sh start_gitlab_service.sh
```
## 停止

```
sh stop_gitlab_service.sh
```


## 基础配置（首次使用）
### 获取access token
1. 账号 root 密码:pa44****
2. 获取access token
访问路径:http://gitlab.basin.site:10000/profile/personal_access_tokens
在Name 填写acctoken名字(自定义)
勾选 
  + **api**
  + **read_user**

  选项,生成token并自行保存,与jenkins互信需要使用。



### 设置ssh-key
访问路径:http://gitlab.basin.site:10000/profile/keys
填写公钥(写入jenkins 用户公钥在jenkins home中，参见jenins 容器化)


### 其他
批量创建命名空间, 由于没有批量创建命名空间接口,通过http request 手动创建一个group 

记录下该http请求,把请求内容替换成需要新的命名空间，在发起请求，可以实现批量创建。




#### 服务健康度

docker ps gitlab (3个容器),待补充

#### 数据安全
持久化数据在/opt/lambda/gitlab_data/，配置数据在/home/basin/gitlab/，


#### 数据导出
先获取access token和设置ssh key 

cd gitlab_mgr
填写配置文件
默认使用配置中global选选项, 也可通过指定-s 指定特定section
首次使用需要先安装依赖
```
使用python3
pip3 install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/
python3 dump_all.py -s gitlab-xxx dump-all-projects
```

#### 数据导入

先获取access token
cd gitlab_mgr
填写配置文件
默认使用配置中global选选项, 也可通过指定-s 指定特定section


```
python3 import_all.py -s gitlab-xxx  import-all-projects
```

#### 数据备份

```
sh backup_gitlab.sh
```

#### 数据还原

```
sh restore_gitlab.sh
依据提示输入还原文件,自动还原
```

#### 服务接口

通过http://gitlab.basin.site:10000访问

#### 服务工具

暂无


#### 关键性能指标
暂无
