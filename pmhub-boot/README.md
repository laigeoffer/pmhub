<p align="center"><img src= "https://cdn.tobebetterjavaer.com/stutymore/pmhub_%E7%AE%80%E4%BB%8B%E7%89%88.png" alt="MaxKB" width="300" /></p>
<h3 align="center">基于 SpringCloud Alibaba & LLM 的智能项目管理系统</h3>
<p align="center">
  <a href="https://opensource.org/license/MIT"><img src="https://img.shields.io/github/license/laigeoffer/pmhub?color=rgb(25%2C%20121%2C%20255)" alt="The MIT License"></a>
  <a href=""><img src="https://img.shields.io/github/forks/laigeoffer/pmhub?color=green" alt="Forks"></a>
  <a href="https://laigeoffer.cn/"><img src="https://img.shields.io/badge/PmHub-%E5%AE%98%E7%BD%91-green" alt="Official"></a>
  <a href="https://github.com/laigeoffer/pmhub"><img src="https://img.shields.io/github/stars/laigeoffer/pmhub?style=flat-square&color=rgb(25%2C%20121%2C%20255)" alt="Stars"></a>    
  <a href="https://pmhub.laigeoffer.cn/"><img src="https://img.shields.io/badge/PmHub-%E4%BD%93%E9%AA%8C%E5%9C%B0%E5%9D%80-blue" alt="Experience"></a>  
</p>

<hr/>
PmHub 是一套基于 SpringCloud Alibaba 分布式微服务 & LLM 的智能项目管理系统，这个项目旨在让同学们快速掌握微服务/分布式项目的架构设计和开发流程，如果想在校招或者社招中拿到一个满意的 offer，PmHub 将是一个非常 nice 的选择。

## 一、项目简介

PmHub 包括用户、流程、项目管理、认证等服务。包含了 Redis 缓存、RocketMQ 消息队列、Docker 容器化、Jenkins 自动化部署、Spring Security 安全框架、Nacos 服务注册和发现、Elasticsearch 搜索引擎、Kibana 可视化工具、Zipkin 链路追踪、OAuth2 统一认证、Vue3 前端框架等互联网开发中需要用到的主流技术栈，可以帮助同学们快速掌握微服务/分布式项目的核心知识点。



>如果对开源项目感兴趣，可以关注二哥的另外一个实战项目：技术派，一个前后端分离的社区项目。[GitHub](https://github.com/itwanger/paicoding) 上已经星标 1.5k+，不少同学就是靠这个项目在往年的校招中拿到了不错的 offer。


为了方便大家循序渐进式的学习，我们将会推出两个版本：

- 单体架构版本：适合初学者，直接运行 pmhub-admin 中的 PmhubApplication 类即可。
- 微服务架构版本：适合有一定基础，想进阶学习微服务/分布式的同学，可以分别启动用户、流程、项目管理、认证等多个服务。

可以根据自己的实际情况选择合适的版本进行学习，我们将会倾其所有，在第一时间帮助大家解决所有学习过程遇到的问题，让你的学习曲线变得非常丝滑😁。

![pmhub 业务架构图](https://cdn.tobebetterjavaer.com/images/README/1711707917318.png)

此为 PmHub 单体版本说明文档！微服务版本说明文档请移步：[https://github.com/laigeoffer/pmhub](https://github.com/laigeoffer/pmhub)

## 二、关于来个 offer 组织

来个 offer 组织由二哥发起，苍何主理，旨在帮助同学们在校招、社招中拿到满意的 offer。

- 二哥，原创公众号“沉默王二”累计 18 万+ 读者，GitHub 星标 11000+ 开源知识库《二哥的 Java 进阶之路》作者，帮助很多很多同学成功拿到满意的 offer。
- 苍何，原创公众号“苍何”作者，前大厂高级开发，曾就职于蚂蚁金服，科大讯飞，现国企技术总监，技术、管理、面试经验丰富。

加入[二哥的编程星球](https://javabetter.cn/zhishixingqiu/)后，即可解锁来个 offer 组织下的所有项目的付费文档，以及 1 对 1 的技术面试辅导服务。

项目|码云|GitHub|简介
---|---|---|---
PmHub| [Gitee](https://gitee.com/laigeoffer/pmhub) | [GitHub](https://github.com/laigeoffer/pmhub) | 一套智能项目管理系统，即将帮助不少同学在接下来的校招/社招中斩获满意 offer。
技术派| [Gitee](https://gitee.com/itwanger/paicoding) | [GitHub](https://github.com/itwanger/paicoding) | 一个前后端分离的社区项目，帮助过不少同学在秋招中斩获满意 offer。

## 三、项目详情
### 3.1、技术架构

下面这张系统架构图可以帮助大家快速了解 PmHub 项目的组织架构，从前端到网关、从服务应用到基础服务、从存储技术到运维部署，可以说是一目了然。

![pmhub-系统架构图](https://cdn.tobebetterjavaer.com/images/README/1711709454988.png)

优质的项目，离不开一张清晰的鸟瞰图（😄）。

### 3.2、项目演示
- 项目仓库（GitHub）：https://github.com/laigeoffer/pmhub
- 项目仓库（码云）：https://gitee.com/laigeoffer/pmhub （国内访问速度更快）
- 项目演示地址：https://pmhub.laigeoffer.cn（微信搜索「苍何」，关注我们的公众号，回复 `pmhub` 获取账号和密码，帮我们增加一个粉丝，哈哈哈，开源不易，请满足一下我的虚荣心（😁）。）

![首页展示](https://cdn.tobebetterjavaer.com/stutymore/20240407163006.png)
![项目概览页](https://cdn.tobebetterjavaer.com/stutymore/202404071500496.png)
![任务编辑页](https://cdn.tobebetterjavaer.com/stutymore/20240407163256.png)

### 3.3、代码展示
![pmhub代码展示](https://cdn.tobebetterjavaer.com/stutymore/20240407164544.png)

### 3.4、代码结构
```
pmhub
├── pmhub-admin -- 核心配置，如：国际化、mybatis、日志、swagger及配置文件
├── pmhub-common -- 通用组件都放在这个模块，各模块公共方法、注解、配置、常量、模型转换、异常、过滤器，全局预防 xss 脚本攻击
├── pmhub-workflow -- 流程管理模块，包含流程分类、表单设计、流程设计、部署管理
├── pmhub-framework -- 关于框架相关功能都在这个模块，如多数据源配置，限流处理、MybatisPlus、redis、连接池配置等
├── pmhub-generator -- 代码生成相关控制器及配置
├── pmhub-oa -- 企微绑定以及第三方 OA 系统绑定，统一登录认证中心
├── pmhub-project -- 涉及项目管理，任务管理、项目设置，任务流转等
├── pmhub-quartz -- 定时任务调度中心
├── pmhub-system -- 对应系统管理模块，含用户管理、角色管理、日志管理等
├── pmhub-ui -- 前端项目源码
```

## 四、项目部署
> 微服务版本请参考：[微服务版本部署手册](https://laigeoffer.cn/)
### 4.1、环境准备
* JDK 1.8
* Maven 3.6
* MySQL 5.7
* Redis 6.0
* RocketMQ 5.0.4


### 4.2、后端项目启动

#### 第一步，下载项目源码

①、使用 Git 命令

网络比较通畅的小伙伴可以直接从 GitHub 上拉取，命令如下：

```
git clone git@github.com:laigeoffer/pmhub.git
```

国内的小伙伴也可以直接使用码云 Gitee 上的镜像仓库地址拉取：

```
git clone https://gitee.com/laigeoffer/pmhub.git
```

②、直接下载压缩包

也可以直接下载 GitHub 上的压缩包，然后解压到本地。

- GitHub 地址：[https://github.com/laigeoffer/pmhub](https://github.com/laigeoffer/pmhub)
- 码云地址：[https://gitee.com/laigeoffer/pmhub](https://gitee.com/laigeoffer/pmhub)

![下载项目源码压缩包](https://cdn.tobebetterjavaer.com/images/20240324/76023993f091417a800ec7da19989e88.png)

③、直接通过 GitHub 桌面版

我个人一直比较喜欢实用 GitHub 桌面版来管理仓库，图形化界面操作起来也比较舒服。

![](https://cdn.tobebetterjavaer.com/images/20240324/27136b6558d84edb861461ca5452021d.png)

#### 第二步，使用 Intellij IDEA 导入项目

这一步应该就不需要我多讲了，相信大家都能搞定。

![](https://cdn.tobebetterjavaer.com/images/20240324/62ee1affa2fd46ed89eaaa2d6931198b.png)

#### 第三步，导入数据库

推荐大家使用 [Navicat](https://javabetter.cn/nice-article/itmind/navicatmacyjpx.html) 这款图形化数据库管理工具。

①、创建数据库 laigeoffer-pmhub

>也可以是其他名字，只要在配置文件里修改对应的数据库名即可。

![](https://cdn.tobebetterjavaer.com/images/20240324/83b5e36a95e04e3d951641215ff16dcf.png)


②、导入数据库文件，路径在 pmhub/sql/pmhub_20240305.sql

![](https://cdn.tobebetterjavaer.com/images/20240324/327783d299814ff8837ab5c3c64b3ff5.png)

可以直接右键在 terminal 终端中打开，然后通过 pwd 和 ls 命令查看文件的绝对路径。

![](https://cdn.tobebetterjavaer.com/images/20240324/24f0cbafe1fb4995827015c294196eb2.png)

拿到绝对路径后，就可以在 Navicat 中导入数据库文件了。

![](https://cdn.tobebetterjavaer.com/images/20240324/aa4cb8f705aa4f46a7d4835c9d26a596.png)

导入完成后，刷新一下就可以看到最新的数据库表了。

#### 第四步，修改配置文件

在 pmhub/pmhub-admin/src/main/resources/application-local.yml 中修改数据库连接信息。

![](https://cdn.tobebetterjavaer.com/images/20240324/6a39a64bee524e5daf4edb388eebf14f.png)

1. 如果数据库名也是 laigeoffer-pmhub，那么只需要修改用户名和密码即可。
2. 如果用户名也是 root，那么只需要修改密码即可。
3. 如果密码也一样，那么就不需要修改了（不可能，绝对不可能这么巧😂）。

#### 第五步，启动 Redis

①、如果你是 macOS 用户，可以直接在终端输入`redis-server`启动 Redis。

![](https://cdn.tobebetterjavaer.com/images/README/1711692102829.png)

②、如果你是 Windows 用户，可以直接双击 redis-server.exe 启动 Redis。

#### 第六步，启动项目

找到 PmhubApplication 类，右键 Run PmhubApplication.main()。

![主类就在 admin 中](https://cdn.tobebetterjavaer.com/images/20240324/7a2259e197014c33be4355025f87266a.png)

如果出现以下的日志，表明项目已经启动成功了。

![](https://cdn.tobebetterjavaer.com/images/20240324/42274fdded6d44cbb942ca951f36bf68.png)

### 4.3、前端项目启动

请参考 pmhub-ui 项目的 README.md 文档，[前端工程结构说明](pmhub-ui/README.md)


### 4.4、Swagger 地址

http://localhost:1024/dev-api/swagger-ui/index.html

### 4.5、服务器部署（Docker 方式）

这里统一以 Debian 系统为例，Centos 系统自行替换操作命令即可！
#### 安装 docker
```shell
1、更新软件包索引：
sudo apt update
2、安装一些必要的软件包，这些软件包允许apt通过HTTPS使用仓库：
sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release
3、添加Docker的官方GPG密钥：
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

4、设置稳定版仓库：
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

5、再次更新软件包索引以包含Docker仓库：
sudo apt update
6、安装Docker Engine：
sudo apt install docker-ce docker-ce-cli containerd.io

7、验证Docker是否安装成功：
sudo docker run hello-world
这条命令会下载一个测试镜像并在容器中运行，如果安装正确，您将看到欢迎信息。
```

#### docker 安装并启动 MySQL 容器
安装启动命令：
```shell
1、安装 mysql
docker pull mysql:5.7
2、运行容器（详细启动挂载如下）
docker run -p 3306:3306 --name mysql \
-v /home/mysql/log:/var/log/mysql \
-v /home/mysql/data:/var/lib/mysql \
--memory 1.5g \
--restart=always \
-e MYSQL_ROOT_PASSWORD=设置mysql密码 -d mysql:5.7
3、阿里云开启安全组
4、防火墙
ufw allow 33706/tcp
```
运行容器各部分解释：
```shell
# 将容器的 3306 端口映射到主机的 3306 端口，这样就可以通过主机的 IP 地址和端口号访问 MySQL 服务。
# 指定容器的名称为 mysql，方便后续管理和操作
docker run -p 3306:3306 --name mysql \
# 将主机的 /home/mysql/log 目录挂载到容器的 /var/log/mysql 目录，用于存储 MySQL 的日志文件。
 -v /home/mysql/log:/var/log/mysql \
 # 将主机的 /home/mysql/data 目录挂载到容器的 /var/lib/mysql 目录，用于存储 MySQL 的数据文件。
 -v /home/mysql/data:/var/lib/mysql \
 # 设置 MySQL 的 root 用户密码为 root。这个参数使用了环境变量来传递密码信息。
 -e MYSOL_ROOT_PASSWORD=123456 \
 # 以后台模式运行 MySQL 容器，
 -d 
 # 内存限制
 --memory
 # 内存保留
 --memory-reservation
 
```

<mark>特别注意：</mark>
端口请设置为非3306，密码尽量设置复杂一些，否则数据库服务很可能被勒索攻击，另外如果可能的话，推荐将数据服务和应用服务分开不要放在一个容易或者一个服务器中。


#### docker 安装并启动 redis
```shell
1、安装redis
docker pull redis
2、启动
docker run --name redis -d -p 6379:6379 redis
3、云服务器安全组
4、开启6379防火墙端口
ufw allow 6379/tcp
```
#### docker 安装并启动 pmhub
先要将 pmhub 上传到你的服务器，或者使用 git clone 拉取最新代码
```shell
# 进入项目目录（进入 pmhub 的路径）
cd /var/lib/xxx/xxx/pmhub


1、打包构建项目
mvn -T 1C clean package -Dmaven.test.skip=true -Dmaven.compile.fork=true

2、构建镜像
mkdir -p build
cp pmhub-admin/target/*.jar build/app.jar
cp Dockerfile.prod build/Dockerfile
cd build
docker build -t pmhub:latest .

3、运行容器
docker run -p 8010:8010 --name pmhub \
-v /home/pmhub:/data \
-d pmhub:latest


4、开启8010端口安全组
5、开启8010端口防火墙
ufw allow 5010/tcp

6、查看容器
docker ps

7、查看容器日志
docker logs pmhub
```
#### 前端部署
<mark>特别注意：</mark>
因 build 需要过多资源且比较慢，如果服务器内存比较小（比如只有2G）推荐采用本地构建后上传到服务器。
```js
npm run build:prod
```
![前端部署](https://cdn.tobebetterjavaer.com/stutymore/20240407174623.png)
把 dist 上传到服务器同级目录下,如果需要域名访问，配置Nginx就可以直接访问啦！

## 五、技术选型

后端技术栈

|         技术          | 说明                   | 官网                                                                                                                         |
|:-------------------:|----------------------|----------------------------------------------------------------------------------------------------------------------------|
| Spring & SpringMVC  | Java全栈应用程序框架和WEB容器实现 | [https://spring.io/](https://spring.io/)                                                                                   |
|     SpringBoot      | Spring应用简化集成开发框架     | [https://spring.io/projects/spring-boot](https://spring.io/projects/spring-boot)                                           |
|       mybatis       | 数据库orm框架             | [https://mybatis.org](https://mybatis.org)                                                                                 |
|    mybatis-plus     | 数据库orm框架             | [https://baomidou.com/](https://baomidou.com/)                                                                             |
| mybatis PageHelper  | 数据库翻页插件              | [https://github.com/pagehelper/Mybatis-PageHelper](https://github.com/pagehelper/Mybatis-PageHelper)                       |
|    elasticsearch    | 近实时文本搜索              | [https://www.elastic.co/cn/elasticsearch/service](https://www.elastic.co/cn/elasticsearch/service)                         |
|        redis        | 内存数据存储               | [https://redis.io](https://redis.io)                                                                                       |
|      rocketmq       | 消息队列                 | [https://rocketmq.apache.org/](https://rocketmq.apache.org/)                                                               |
|       mongodb       | NoSql数据库             | [https://www.mongodb.com/](https://www.mongodb.com/)                                                                       |
|        nginx        | 服务器                  | [https://nginx.org](https://nginx.org)                                                                                     |
|       docker        | 应用容器引擎               | [https://www.docker.com](https://www.docker.com)                                                                           |
|      hikariCP       | 数据库连接                | [https://github.com/brettwooldridge/HikariCP](https://github.com/brettwooldridge/HikariCP)                                 |
|         oss         | 对象存储                 | [https://help.aliyun.com/document_detail/31883.html](https://help.aliyun.com/document_detail/31883.html)                   |
|        https        | 证书                   | [https://letsencrypt.org/](https://letsencrypt.org/)                                                                       |
|         jwt         | jwt登录                | [https://jwt.io](https://jwt.io)                                                                                           |
|       lombok        | Java语言增强库            | [https://projectlombok.org](https://projectlombok.org)                                                                     |
|        guava        | google开源的java工具集     | [https://github.com/google/guava](https://github.com/google/guava)                                                         |
|      thymeleaf      | html5模板引擎            | [https://www.thymeleaf.org](https://www.thymeleaf.org)                                                                     |
|       swagger       | API文档生成工具            | [https://swagger.io](https://swagger.io)                                                                                   |
| hibernate-validator | 验证框架                 | [hibernate.org/validator/](hibernate.org/validator/)                                                                       |
|     quick-media     | 多媒体处理                | [https://github.com/liuyueyi/quick-media](https://github.com/liuyueyi/quick-media)                                         |
|      liquibase      | 数据库版本管理              | [https://www.liquibase.com](https://www.liquibase.com)                                                                     |
|       jackson       | json/xml处理           | [https://www.jackson.com](https://www.jackson.com)                                                                         |
|      ip2region      | ip地址                 | [https://github.com/zoujingli/ip2region](https://github.com/zoujingli/ip2region)                                           |
|      websocket      | 长连接                  | [https://docs.spring.io/spring/reference/web/websocket.html](https://docs.spring.io/spring/reference/web/websocket.html)   |
|   sensitive-word    | 敏感词                  | [https://github.com/houbb/sensitive-word](https://github.com/houbb/sensitive-word)                                         |
|       chatgpt       | chatgpt              | [https://openai.com/blog/chatgpt](https://openai.com/blog/chatgpt)                                                         |
|        讯飞星火         | 讯飞星火大模型              | [https://www.xfyun.cn/doc/spark/Web.html](https://www.xfyun.cn/doc/spark/Web.html#_1-%E6%8E%A5%E5%8F%A3%E8%AF%B4%E6%98%8E) |

## 六、PmHub 教程
PmHub 教程共 100+ 篇，从中整理出 15 篇，供大家免费学习。
- [（🌟 新人必看）PmHub 系统架构&功能模块一览](https://laigeoffer.cn/)
- [（🌟 新人必看）小白如何学习 PmHub](https://laigeoffer.cn/)
- [（🌟 新人必看）如何将 PmHub 写入简历](https://laigeoffer.cn/)
- [（🌟 新人必看）PmHub 架构方案设计](https://laigeoffer.cn/)
- [（🌟 新人必看）PmHub 技术方案设计](https://laigeoffer.cn/)
- [（🌟 新人必看）PmHub 项目管理流程](https://laigeoffer.cn/)
- [（🌟 新人必看）PmHub 分层架构](https://laigeoffer.cn/)
- [（🌟 新人必看）PmHub 项目工程搭建手册](https://laigeoffer.cn/)
- [（👍 强烈推荐）PmHub 企业微信自动登录](https://laigeoffer.cn/)
- [（👍 强烈推荐）PmHub Mysql/Redis缓存一致性](https://laigeoffer.cn/)
- [（👍 强烈推荐）PmHub 消息队列 Rocketmq](https://laigeoffer.cn/)
- [（👍 强烈推荐）PmHub 实现接入 flowable 流程管理](https://laigeoffer.cn/)
- [（👍 强烈推荐）PmHub 分布式事务实现](https://laigeoffer.cn/)
- [（👍 强烈推荐）PmHub 定时任务实现](https://laigeoffer.cn/)
- [（👍 扬帆起航）送给坚持到最后的自己，一起杨帆起航](https://laigeoffer.cn/)


## 七、环境搭建

### 开发工具

|        工具        | 说明           | 官网                                                                                                                       | 
|:----------------:|--------------|--------------------------------------------------------------------------------------------------------------------------|
|       IDEA       | java开发工具     | [https://www.jetbrains.com](https://www.jetbrains.com)                                                                   |
|   visualstudio   | web开发工具      | [https://code.visualstudio.com/](https://code.visualstudio.com/)                                                         |
|      Chrome      | 浏览器          | [https://www.google.com/intl/zh-CN/chrome](https://www.google.com/intl/zh-CN/chrome)                                     |
|   ScreenToGif    | gif录屏        | [https://www.screentogif.com](https://www.screentogif.com)                                                               |
|     SniPaste     | 截图           | [https://www.snipaste.com](https://www.snipaste.com)                                                                     |
|     PicPick      | 图片处理工具       | [https://picpick.app](https://picpick.app)                                                                               |
|     MarkText     | markdown编辑器  | [https://github.com/marktext/marktext](https://github.com/marktext/marktext)                                             |
|       curl       | http终端请求     | [https://curl.se](https://curl.se)                                                                                       |
|     Postman      | API接口调试      | [https://www.postman.com](https://www.postman.com)                                                                       |
|     draw.io      | 流程图、架构图绘制    | [https://www.diagrams.net/](https://www.diagrams.net/)                                                                   |
|      Axure       | 原型图设计工具      | [https://www.axure.com](https://www.axure.com)                                                                           |
|     navicat      | 数据库连接工具      | [https://www.navicat.com](https://www.navicat.com)                                                                       |
|     DBeaver      | 免费开源的数据库连接工具 | [https://dbeaver.io](https://dbeaver.io)                                                                                 |
|      iTerm2      | mac终端        | [https://iterm2.com](https://iterm2.com)                                                                                 |
| windows terminal | win终端        | [https://learn.microsoft.com/en-us/windows/terminal/install](https://learn.microsoft.com/en-us/windows/terminal/install) |
|   SwitchHosts    | host管理       | [https://github.com/oldj/SwitchHosts/releases](https://github.com/oldj/SwitchHosts/releases)                             |


### 开发环境

|      工具       | 版本        | 下载                                                                                                                     |
|:-------------:|:----------|------------------------------------------------------------------------------------------------------------------------|
|      jdk      | 1.8+      | [https://www.oracle.com/java/technologies/downloads/#java8](https://www.oracle.com/java/technologies/downloads/#java8) |
|     maven     | 3.4+      | [https://maven.apache.org/](https://maven.apache.org/)                                                                 |
|     mysql     | 5.7+/8.0+ | [https://www.mysql.com/downloads/](https://www.mysql.com/downloads/)                                                   |
|     redis     | 5.0+      | [https://redis.io/download/](https://redis.io/download/)                                                               |
| elasticsearch | 8.0.0+    | [https://www.elastic.co/cn/downloads/elasticsearch](https://www.elastic.co/cn/downloads/elasticsearch)                 |
|     nginx     | 1.10+     | [https://nginx.org/en/download.html](https://nginx.org/en/download.html)                                               |
|   rocketmq    | 5.0.4+    | [https://www.rabbitmq.com/news.html](https://www.rabbitmq.com/news.html)                                               |
|    ali-oss    | 3.15.1    | [https://help.aliyun.com/document_detail/31946.html](https://help.aliyun.com/document_detail/31946.html)               |
|      git      | 2.34.1    | [http://github.com/](http://github.com/)                                                                               |
|    docker     | 4.10.0+   | [https://docs.docker.com/desktop/](https://docs.docker.com/desktop/)                                                   |
|    freessl    | https证书   | [https://freessl.cn/](https://freessl.cn/)                                                                             |

### 搭建步骤

#### 本地部署教程

> [本地开发环境手把手教程](docs/本地开发环境配置教程.md)

### 云服务器部署教程

> [环境搭建 & 基于源码的部署教程](docs/安装环境.md)
> [服务器docker启动教程](docs/服务器启动教程.md)

## 八、内置功能

1.  用户管理：用户是系统操作者，该功能主要完成系统用户配置。
2.  部门管理：配置系统组织机构（公司、部门、小组），树结构展现支持数据权限。
3.  岗位管理：配置系统用户所属担任职务。
4.  菜单管理：配置系统菜单，操作权限，按钮权限标识等。
5.  角色管理：角色菜单权限分配、设置角色按机构进行数据范围权限划分。
6.  字典管理：对系统中经常使用的一些较为固定的数据进行维护。
7.  参数管理：对系统动态配置常用参数。
8.  通知公告：系统通知公告信息发布维护。
9.  操作日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。
10. 登录日志：系统登录日志记录查询包含登录异常。
11. 在线用户：当前系统中活跃用户状态监控。
12. 定时任务：在线（添加、修改、删除)任务调度包含执行结果日志。
13. 代码生成：前后端代码的生成（java、html、xml、sql）支持CRUD下载 。
14. 系统接口：根据业务代码自动生成相关的api接口文档。
15. 服务监控：监视当前系统CPU、内存、磁盘、堆栈等相关信息。
16. 缓存监控：对系统的缓存信息查询，命令统计等。
17. 在线构建器：拖动表单元素生成相应的HTML代码。
18. 连接池监视：监视当前系统数据库连接池状态，可进行分析SQL找出系统性能瓶颈。

## 九、友情链接

- [laigeoffer](https://github.com/laigeoffer) ：🚀🚀🚀来个 offer 官方社区，这里汇集了很多的校招/社招优质项目，助力学生党和工作党拿个更好的 offer💪🏻
- [paicoding](https://github.com/itwanger/paicoding?tab=readme-ov-file) ：⭐️一款好用又强大的开源社区，基于 Spring Boot、MyBatis-Plus、MySQL、Redis、ElasticSearch、MongoDB、Docker、RabbitMQ 等主流技术栈
- [toBeBetterjavaer](https://github.com/itwanger/toBeBetterJavaer) ：一份通俗易懂、风趣幽默的Java学习指南，内容涵盖Java基础、Java并发编程、Java虚拟机、Java企业级开发、Java面试等核心知识点。学Java，就认准二哥的Java进阶之路😄


## 十、鸣谢
感谢所有参与开源贡献的小伙伴，PmHub 因你们而更强大！

## 十一、star 趋势图

[![Star History Chart](https://api.star-history.com/svg?repos=laigeoffer/pmhub&type=Date)](https://star-history.com/#laigeoffer/pmhub&Date)

## 十二、公众号

微信搜 **苍何** 或扫描下方二维码关注苍何的原创公众号，回复 **666** 即可免费领取 2000G 编程学习资源。

![苍何微信公众号](https://cdn.tobebetterjavaer.com/stutymore/%E6%89%AB%E7%A0%81_%E6%90%9C%E7%B4%A2%E8%81%94%E5%90%88%E4%BC%A0%E6%92%AD%E6%A0%B7%E5%BC%8F-%E6%A0%87%E5%87%86%E8%89%B2%E7%89%88.png)

## 十三、许可证

[MIT License (MIT)](https://opensource.org/licenses/MIT)<hr/>
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

Copyright (c) 2023-2024 PmHub（苍何、沉默王二）


