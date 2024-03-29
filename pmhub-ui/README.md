## pmhub-ui 介绍

## pmhub-ui 启动说明

第一步，推荐使用 VSCode 打开 pmhub-ui 项目。

![](https://cdn.tobebetterjavaer.com/stutymore/README-20240329133716.png)

第二步，打开终端，执行 `npm install` 安装依赖：

项目依赖 Nodejs 环境，需要提前安装。此处略过。

![](https://cdn.tobebetterjavaer.com/stutymore/README-20240324122950.png)

不建议直接使用 cnpm 安装依赖，会有各种诡异的 bug。可以通过如下操作解决 npm 下载速度慢的问题。

```bash
npm install --registry=https://registry.npmmirror.com
```

如果出现 `npm ERR! code EIDLETIMEOUT` 错误，一般是因为网络问题导致的，可以重新再执行一次 `npm install`。

第三步，安装完依赖后，执行 `npm run dev` 启动项目：

如果 Nodejs 版本过新，可能会出现`Error: error:0308010C:digital envelope routines::unsupported`这个问题。

![](https://cdn.tobebetterjavaer.com/stutymore/README-20240324123352.png)

①、如果你是 Windows 用户，可以在 cmd 命令行中输入以下命令：

```bash
set NODE_OPTIONS=--openssl-legacy-provider
```

也可以在 PowerShell 中输入以下命令：

```bash
$env:NODE_OPTIONS="--openssl-legacy-provider"
```

②、如果你是 macOS 用户，可以在终端中输入以下命令：

```bash
export NODE_OPTIONS=--openssl-legacy-provider
```

之后再次执行 `npm run dev` 即可正常启动项目。

![](https://cdn.tobebetterjavaer.com/stutymore/README-20240324123905.png)

浏览器会自动打开 `http://localhost:1024`，即可看到 pmhub-ui 项目登录页面。

![](https://cdn.tobebetterjavaer.com/stutymore/README-20240324124027.png)

第四步，微信搜索「苍何」，关注我们的公众号，回复 `pmhub` 获取账号和密码，帮我们增加一个粉丝，哈哈哈，开源不易，请满足一下我的虚荣心（😁）。

![](https://cdn.tobebetterjavaer.com/stutymore/README-20240329142637.png)

第五步，输入账号密码登录，即可看到 pmhub-ui 项目主页。

## pmhub-ui 发布说明

```bash
# 构建测试环境
npm run build:stage

# 构建生产环境
npm run build:prod
````

## 模块划分

- 项目管理：pmhub-project
- 采购管理：pmhub-purchase
- 物料管理：pmhub-materials
- 库存管理：pmhub-storehouse
- 审批管理：pmhub-approval

## Git 提交规范参考

- `feat` 增加新的业务功能
- `fix` 修复业务问题/BUG
- `perf` 优化性能
- `style` 更改代码风格, 不影响运行结果
- `refactor` 重构代码
- `revert` 撤销更改
- `test` 测试相关, 不涉及业务代码的更改
- `docs` 文档和注释相关
- `chore` 更新依赖/修改脚手架配置等琐事
- `workflow` 工作流改进
- `ci` 持续集成相关
- `types` 类型定义文件更改
- `wip` 开发中
- `api` 接口联调

## 教程

[前端手册](http://doc.ruoyi.vip/ruoyi-vue/document/qdsc.html#%E5%89%8D%E7%AB%AF%E6%89%8B%E5%86%8C)

## 跨域

该项目解决跨域问题通过反向代理，故部署时需对 Nginx 进行对应配置。

可以参考配置如下：

[img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ee708e10a7204848803282dc2dfc7a4e~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.image)
[docs](http://doc.ruoyi.vip/ruoyi-vue/document/hjbs.html#nginx%E9%85%8D%E7%BD%AE)
