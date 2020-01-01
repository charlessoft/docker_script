# 持续集成框架

## 概述
持续集成框架,遵循git-flow开发流程,从gitlab拉取代码,构建指定版本,并分发到发布服务器.

## 安装部署

### 基础环境准备

**集群各主机上必须安装部署docker引擎**  
1. docker 安装部署 详见平台首页
2. jenkins 安装部署 详见平台首页
3. gitlab 安装部署 详见平台首页



#### 基础配置

#####1. jenkins 配置参见jenkins/README.md
#####2. gitlab 配置参见gitlab/README.md

#####3. 获取access token
1. 账号 root 密码:pa44****
2. 获取access token
访问路径:http://gitlab.basin.site:10000/profile/personal_access_tokens
在Name 填写acctoken名字(自定义)
勾选
  + **api**
  + **read_user**

  选项,生成token并自行保存,与jenkins互信需要使用。


#####4. 配置gitlab和jenkins 互信  
+ 生成证书  
   访问:http://jenkins.basin.site:9090/credentials/store/system

| 名称 | 值 |
| --- | --- |
|选择类型| Gitlab Api Token |
|Api Token| gitlab 中获取的access token|
|ID| 可以为空(自动生成)|
|描述| 自定义填写(pt4_gitlab_api_token)|
   
+ 访问: http://jenkins.basin.site:9090/configure  在 Gitlab选项中配置

| 名称 | 值 |
| --- | --- |
| Connection name | gitlab.basin.site |
| Gitlab host URL | http://gitlab.basin.ali:10000 |
| Credentials | 选择上一步创建的证书名称 |

      可以点击Test Connection测试是否连接成功, Success表示成功
  + 使用管理员登录gitlab服务器  
      访问:http://gitlab.basin.site:10000/profile/keys  增加jenkins ssh id_rsa.pub 用于有权限下载代码


#####5. 配置发布服务器  

访问: http://jenkins.basin.site:9090/configure  

a) 在`环境变量`选项中,添加如下环境变量

| 名称 | 值 |
| --- | --- |
| DOCKER_PRIVATE_SERVER | registry.basin.site:8050 |


b) 找到Publish over SSH选项

| 名称 | 值 |
| --- | --- |
| Passphrase | 空 |
| Path to key | 空 |
| key | 贴jenkins 账户id_rsa 内容 |
| SSH Servers | 点击增加 |
| SSH Servers-ssh Server-Name | release-server\(固定,jenkinsfile中需要\) |
| SSH Servers-ssh Server-Hostname | ip地址 |
| SSH Servers-ssh Server-Username | jenkins |
| SSH Servers-ssh Server-Remote Directory | 发布服务器跟目录\(需要有权限访问\) |

   点击 Test Connection,返回success表示成功

#####6. 配置SonarQube servers选项 \(如果jenkinsfile中有调用sonar,必须写\)  
访问: http://jenkins.basin.site:9090/configure  
   找到Environment variables  
   勾选 `Enable injection of SonarQube server configuration as build environment variables`

| 名称 | 值 |
| --- | --- |
| Name | sonarqube |
| Server URL | http://xxx.xxx.xxx.xxx:9000 |
| Server authentication | xxx |

#####7. 配置钉钉群消息通知 
访问: http://jenkins.basin.site:9090/configure  
   找到`环境变量`选项

   | 名称 | 值 |
| --- | --- |
| DINGDING_SERVER | xxx(钉钉群配置,获取url) |




## demo示例
参见 demo工程

## 文档说明:
1. [git-flow规范](./docs/git_flow_intro.md)
2. [创建项目流程](./docs/gitlab_intro.md)
3. [持续集成构建流程](./docs/ci_intro.md)
