# jenkins 基础容器使用

## 安装部署

### 基础环境准备

**集群各主机上必须安装部署docker引擎**  
参见[docker 安装部署](../baseimage/dockerd.md)

## 
### jenkins

提供Lambda平台自身的离线安装部署能力，及平台内应用服务的持续部署能力。  
假设服务运行主机jenkins.basin.site。

#### 依赖

创建jenkins 用户, 由于jenkins 是由docker启动作为master 角色，不参与编译，只在slave节点远程登录,采用事先创建互信授权方式。可以使用已有账户，需要手动建立互信。

```
sh create_ci_jenkins_user.sh  
该脚本创建jenkins用户，并使用事先生成好的ssh key，如需修改key，在.ssh目录下修改。
```

#### 服务架构

单机容器化部署，应用目录/home/basin/jenkins/，数据目录/opt/lambda/jenkins_data/。  
启动脚本`sh start_jenkins_service.sh`，访问端口10000。  
默认管理员账号:root,密码:pa4_**_d


#### 安装

```
需要在config.sh 中配置数据存储路径和备份路径
sh install_docker_jenkins.sh
```

#### 启动

```
sh start_jenkins_service.sh
```

#### 停止

```
sh stop_jenkins_service.sh
```


#### 基础配置

#### 默认端口

| 服务 | 端口号 |
| --- | --- |
| jenkins | 9090 |



访问jenkins页面依据提示安装基础插件。

#####1. 访问路径http://jenkins.basin.site:9090/login  
   输入密码:密码路径为配置文件中DOCKER_JENKINS_VOLUME指向的路径

   ```
   cat ${DOCKER_JENKINS_VOLUME}/jenkins_home/secrets/initialAdminPassword
   通过终端输出界面已经输出该密码.
   ```

#####2. 安装推荐插件  
   在自定义Jenkins 页面中选择'安装推荐插件' 等待安装完毕

#####3. 创建第一个管理员  
   例如: jenkins pa44*****,如果不创建,则使用系统默认admin和步骤1的输出和密码.
   如果选择创建管理员账户,默认的admin和密码会被清空,也可以按照说明,不创建管理员账户使用admin账户

持续集成服务依赖 slave机器编译部署,

#####5. 配置私钥（与slave互信）  
   访问:[http://jenkins.basin.site:9090/credentials/store/system](http://jenkins.basin.site:9090/credentials/store/system)    

点击全局凭证->在点击添加凭证按钮,增加凭证

| 名称 | 值 |
| --- | --- |
| 类型选择 | SSH UserName with private key |
| 范围 | 全局 |
| Username | jenkins |
| Private Key | 贴 jenkins container 中/var/jenkins_home/.ssh/id_rsa内容(安装部署脚本目录下ssh_key/id_rsa) |
| Passphrase | 如果你在创建 ssh key 的时候输入了 Passphrase那就填写相应的Passphrase，为空就不填写 |
| ID | 空 |
| Description | 自定义(方便记忆就好) |

#####6. 配置slave 机器  

   <span style="color:red">**需要事先创建好jenkins用户(建议),参见基础环境-依赖部分**</span>



docker jenkins 仅只负责master 工作，需要配置slave，**需要在slave创建jenkins账户并设置互信**  

   访问:[http://jenkins.basin.site:9090/computer/new](http://jenkins.basin.site:9090/computer/new)  



| 名称 | 值 |
| --- | --- |
| 节点名称 | linux_slave |
| 固定节点 | 勾选 |

点击下一步

| 名称 | 值 |
| --- | --- |
| 名字 | linux_slave |
| 描述 | 选填 |
| 并发构建数 | 2(默认1) |
| 远程工作目录 | /mnt/workspace/(自定义指定大容器目录) |
| Host Key Verification Strategy | Non Verifying Verification Strategy |

如果使用已存在账户,需要事先进行互信授权,把 jenkins id_rsa.pub保存到已存在账户authorized_keys中


#### 服务健康度

http://jenkins.basin.site:9090

#### 数据安全

持久化数据在/opt/lambda/jenkins\_data/，配置数据在/home/basin/jenkins/，

#### 数据导出

暂无

#### 数据导入

暂无


#### 数据备份

```
sh backup_jenkins.sh
```

#### 数据还原

```
sh restore_jenkins.sh
```

#### 服务接口

通过 http://jenkins.basin.site:9090访问

#### 服务工具

暂无

#### 关键性能指标

暂无

