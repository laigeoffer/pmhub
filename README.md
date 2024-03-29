# 项目简介

PmHub 是一套智能项目管理系统，包括用户、流程、项目管理、认证等服务。

这个项目旨在让同学们快速掌握微服务/分布式项目的架构设计和开发流程，如果想在校招或者社招中拿到一个满意的 offer，PmHub 将是一个非常 nice 的选择。

>如果对开源项目感兴趣，可以关注二哥的另外一个实战项目：技术派，一个前后端分离的社区项目。[GitHub](https://github.com/itwanger/paicoding) 上已经星标 1.5k+，不少同学就是靠这个项目在往年的校招中拿到了不错的 offer。

PmHub 包含了 Redis 缓存、RocketMQ 消息队列、Docker 容器化、Jenkins 自动化部署、Spring Security 安全框架、Nacos 服务注册和发现、Elasticsearch 搜索引擎、Kibana 可视化工具、Zipkin 链路追踪、OAuth2 统一认证、Vue3 前端框架等互联网开发中需要用到的主流技术栈，可以帮助同学们快速掌握微服务/分布式项目的核心知识点。

为了方便大家循序渐进式的学习，我们将会推出两个版本：

- 单体架构版本：适合初学者，直接运行 pmhub-admin 中的 PmhubApplication 类即可。
- 微服务架构版本：适合有一定基础，想进阶学习微服务/分布式的同学，可以分别启动用户、流程、项目管理、认证等多个服务。

可以根据自己的实际情况选择合适的版本进行学习，我们将会倾其所有，在第一时间帮助大家解决所有学习过程遇到的问题，让你的学习曲线变得非常丝滑😁。

![pmhub 业务架构图](https://cdn.tobebetterjavaer.com/images/README/1711707917318.png)

# 关于来个 offer 组织

来个 offer 组织由二哥发起，苍何主理，旨在帮助同学们在校招、社招中拿到满意的 offer。

- 二哥，原创公众号“沉默王二”累计 18 万+ 读者，GitHub 星标 11000+ 开源知识库《二哥的 Java 进阶之路》作者，帮助很多很多同学成功拿到满意的 offer。
- 苍何，原创公众号“苍何”作者，前阿里 P7，曾就职于蚂蚁金服，现国企技术总监，技术、管理、面试经验丰富。

加入[二哥的编程星球](https://javabetter.cn/zhishixingqiu/)后，即可解锁来个 offer 组织下的所有项目的付费文档，以及 1 对 1 的技术面试辅导服务。

项目|码云|GitHub|简介
---|---|---|---
PmHub| [Gitee](https://gitee.com/laigeoffer/pmhub) | [GitHub](https://github.com/laigeoffer/pmhub) | 一套智能项目管理系统，即将帮助不少同学在接下来的校招/社招中斩获满意 offer。
技术派| [Gitee](https://gitee.com/itwanger/paicoding) | [GitHub](https://github.com/itwanger/paicoding) | 一个前后端分离的社区项目，帮助过不少同学在秋招中斩获满意 offer。

# 技术架构

下面这张系统架构图可以帮助大家快速了解 PmHub 项目的组织架构，从前端到网关、从服务应用到基础服务、从存储技术到运维部署，可以说是一目了然。

![pmhub-系统架构图](https://cdn.tobebetterjavaer.com/images/README/1711709454988.png)

优质的项目，离不开一张清晰的鸟瞰图（😄）。

## 模块简介
### 1、pmhub-admin
* web 层controller
* 核心配置，如：国际化、mybatis、日志、swagger及配置文件
* 项目启动类

### 2、pmhub-common
* 各模块公共方法、注解、配置、常量、模型转换、异常、过滤器
* 全局预防 xss 脚本攻击
* 公共枚举
* 公共分类（物料分类、供应商分类、零部件分类）

### 3、pmhub-workflow
* 流程管理-流程分类
* 流程管理-表单设计
* 流程管理-流程设计
* 流程管理-部署管理


### 4、pmhub-framework
* 数据过滤处理、多数据源处理
* 操作日志记录
* 限流处理
* 配置：Druid 配置、时区配置、验证码配置（弃用）、druid 配置多数据源、MybatisPlus、redis、连接池配置
* 数据源配置
* 拦截器、异步任务控制
* 安全控制：身份认证及权限、token 过滤
* 服务器相关信息
* 全局异常处理器
* 自定义权限、登录检验、websocket相关控制

### 5、pmhub-generator
* 代码生成相关控制器及配置


### 6、pmhub-oa
* 绑定企微通知、企微用户关联绑定

### 7、pmhub-project

* 项目管理-我的项目
* 项目管理-我的任务
* 项目管理-我的收藏
* 项目管理-回收站



### 8、pmhub-quartz
* 定时任务调度


### 9、pmhub-system
* 系统管理-用户管理
* 系统管理-角色管理
* 系统管理-菜单管理
* 系统管理-部门管理
* 系统管理-岗位管理
* 系统管理-字典管理
* 系统管理-参数设置
* 系统管理-通知公告
* 系统管理-日志管理

## 项目部署
### 1、环境准备
* JDK 1.8
* Maven 3.6
* MySQL 5.7
* Redis 6.0
* RocketMQ 4.8
* Nacos 2.0
* Elasticsearch 7.10

### 2、后端项目启动

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

### 3、前端项目启动

请参考 pmhub-ui 项目的 README.md 文档。

### 4、Swagger 地址

http://localhost:1024/dev-api/swagger-ui/index.html

### 5、项目部署
* 1、打包项目
* 2、上传服务器
* 3、启动项目
* 4、访问项目
* 5、登录账号：admin 密码：123456

### 6、项目配置
* 1、数据库配置
* 2、redis配置
* 3、rocketmq配置




## 开发规范
1、返回格式定义必须是以下格式
```
{
	"code": 200,
	"msg": "success",
	"data": null
}
```

2、返回page格式
```
{       
	"code": 200,        
	"msg": "success",       
	"data": {       
		"list": [],     
        "total": 0,     
		"size": 1,      
		"current": 10,      
		"searchCount": true,        
		"pages": 0      
	}
}
```

3、命名规范

遵守阿里编码规范，在idea安装插件。     
返回字段，请求地址统一采用驼峰。
工具类以Utils结尾，例如JWTUtils
枚举统一采用Enum结尾，例如 ResultEnum

4、git commit规范

|  功能   | commit规范  | 示例 | 描述 |
|  ----  | ----  | ---- | ---- |
| 新功能  | feature/module_name | feature/multi_merchant | 开发一个新功能 |
| bug修复  | bugfix/fix_name | bugfix/user | 修复某个功能模块的bug |
| 紧急修复  | hotfix/fix_name | hotfix/create_order | 紧急修复某个严重bug |
| 性能优化  | perf/name | pref/user_login | 优化某个功能的性能 |
| 格式调整  | style/name | style/log_print | 做一下不影响任何业务的优化，比如删掉不使用了的注释之类 |
| 重构  | refactor/name | refactor/user | 重构某个功能模块 |   

## 内置功能

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

