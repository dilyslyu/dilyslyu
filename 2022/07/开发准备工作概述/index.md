# 开发准备工作概述


### 开发环境搭建

node 安装；
本项目基于 vue-cli.3.0 搭建,要求 node 版本：8+。

### 开发工具安装

1. 安装 vscode IDE；
2. 安装 vscode 插件；
3. 了解接口文档登记平台；
4. 安装 eslint 插件，代码规范通过 .eslintrc.js 进行配置
5. 如果同时安装了 vetur ，Eslint 的某些规则可能和 vetur 产生冲突，需要关闭 vetur 的校验和自动化功能。

### 工程项目初始化及常见报错

1. 在项目根目录下初始化：
` npm install `
2. 如果执行报错 
2.1 `node-sass` 报错
在 `.npmrc` 文件中配置 `sass_binary_site`: `sass_binary_site = http://XXX/XXX/npm/node-sass`；
检查 package.json 中的 node-sass 版本
2.2 .npmrc 文件中是否配置了 registry
`registry = http://XXX/XXX/repository/npm-public`

3. 在设计阶段与后端商定涉及的接口和字段；
4. 启动项目
`npm run serve`

