## 开发

```bash
# 安装依赖
npm install

# 建议不要直接使用 cnpm 安装依赖，会有各种诡异的 bug。可以通过如下操作解决 npm 下载速度慢的问题
npm install --registry=https://registry.npmmirror.com

# 如果nodejs版本过新(Error: error:0308010C:digital envelope routines::unsupported)，
# win 用户输入命令：
$env:NODE_OPTIONS="--openssl-legacy-provider"
# mac 用户输入命令：
export NODE_OPTIONS=--openssl-legacy-provider

# 启动服务

npm run dev
```

浏览器访问 http://localhost:80

## 发布

```bash
# 构建测试环境
npm run build:stage

# 构建生产环境
npm run build:prod
```

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
