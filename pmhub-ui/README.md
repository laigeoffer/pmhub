## pmhub-ui 介绍

## pmhub-ui 启动说明

第一步，推荐使用 VSCode 打开 pmhub-ui 项目。

![导入 pmhub-ui 项目：微服务版](https://cdn.tobebetterjavaer.com/stutymore/README-20240329133716.png)

第二步，打开终端，执行 `npm install` 安装依赖：

项目依赖 Nodejs 环境，需要提前安装。此处略过。

![执行 npm install](https://cdn.tobebetterjavaer.com/stutymore/README-20240324122950.png)

不建议直接使用 cnpm 安装依赖，会有各种诡异的 bug。可以通过如下操作解决 npm 下载速度慢的问题。

```bash
npm install --registry=https://registry.npmmirror.com
```

如果出现 `npm ERR! code EIDLETIMEOUT` 错误，一般是因为网络问题导致的，可以重新再执行一次 `npm install`。

第三步，安装完依赖后，执行 `npm run dev` 启动项目：

![npm run dev](https://cdn.tobebetterjavaer.com/stutymore/README-20240324123905.png)

### pmhub 启动可能遇到的问题

如果 Nodejs 版本过新，可能会出现`Error: error:0308010C:digital envelope routines::unsupported`这个问题。

![nodejs 版本过新](https://cdn.tobebetterjavaer.com/stutymore/README-20240324123352.png)

①、如果是 Windows 用户，可能出现下面这个错误。

>"NODE OPTIONS"不是内部或外部命令，也不是可运行的程序或批处理文件。

![Windows 用户：NODE_OPTIONS](https://cdn.tobebetterjavaer.com/stutymore/README-20240830181030.png)

一种做法是执行 `npm run serve`，而不是 `npm run dev`。我在 package.json 文件中加过处理了：

![](https://cdn.tobebetterjavaer.com/stutymore/README-20240830181331.png)

另外一种做法是仍然执行 `npm run dev`，但是在终端中输入以下命令：

```bash
set NODE_OPTIONS=--openssl-legacy-provider
```

也可以在 PowerShell 中输入以下命令：

```bash
$env:NODE_OPTIONS="--openssl-legacy-provider"
```

还有球友（马嘉杰）的解决办法是（有点怪）：

nodejs 版本是 17.0.0。

直接 `npm run dev` 还是会报错 `NODE_OPTIONS 不是内部命令或外部命令`。

把 `NODE_OPTIONS=--openssl-legacy-provider` 删除，接着会报错 `Error: error:0308010C:digital envelope routines::unsupported；`

然后在 PowerShell 中输入以下命令：

`$env:NODE_OPTIONS="--openssl-legacy-provider"`


②、如果你是 macOS 用户，通常不会出现这个问题，因为我在 package.json 文件中加过处理了：

![package.json加过 macOS 的处理了](https://cdn.tobebetterjavaer.com/stutymore/README-20240830180848.png)

如果你还是遇到问题，可以在终端中输入以下命令：

```bash
export NODE_OPTIONS=--openssl-legacy-provider
```

浏览器会自动打开 [http://localhost:1024](http://localhost:1024)，即可看到 pmhub-ui 项目的首页。

![二哥的 PmHub：前端首页](https://cdn.tobebetterjavaer.com/stutymore/README-20240830180441.png)

## pmhub-ui 发布说明

```bash
# 构建测试环境
npm run build:stage

# 构建生产环境
npm run build:prod
```

## 模块划分

- 项目管理：pmhub-project
- 审批管理：pmhub-approval

## git commit规范

| 功能    | commit规范         | 示例                  | 描述                          |
|-------|------------------|---------------------|-----------------------------|
| 新功能   | feat/module_name | feat/multi_merchant | 开发一个新功能                     |
| bug修复 | bugfix/fix_name  | bugfix/user         | 修复某个功能模块的bug                |
| 紧急修复  | hotfix/fix_name  | hotfix/create_order | 紧急修复某个严重bug                 |
| 性能优化  | perf/name        | pref/user_login     | 优化某个功能的性能                   |
| 格式调整  | style/name       | style/log_print     | 做一下不影响任何业务的优化，比如删掉不使用了的注释之类 |
| 重构    | refactor/name    | refactor/user       | 重构某个功能模块                    |   
| 测试    | test/name        | test/user           | 测试相关, 不涉及业务代码的更改            |   
| 文档和注释 | docs/name        | docs/user           | 文档和注释相关                     |   
| 更新依赖等 | chore/name       | chore/user          | 更新依赖/修改脚手架配置等琐事             |   


## 教程

[前端手册](http://doc.ruoyi.vip/ruoyi-vue/document/qdsc.html#%E5%89%8D%E7%AB%AF%E6%89%8B%E5%86%8C)

## 跨域

该项目解决跨域问题通过反向代理，故部署时需对 Nginx 进行对应配置。

可以参考配置如下：

[img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ee708e10a7204848803282dc2dfc7a4e~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.image)
[docs](http://doc.ruoyi.vip/ruoyi-vue/document/hjbs.html#nginx%E9%85%8D%E7%BD%AE)
