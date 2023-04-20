---
title: "使用 Vite 创建一个 React 项目"
subtitle: ""
date: 2023-04-18T18:21:12+08:00
lastmod: 2023-04-18T18:21:12+08:00
draft: false
author: "Dilys.Lyu"
authorLink: "https://dilysluy.com"
description: "这里是 Dilys.Lyu 的博客，欢迎访问！"
tags: []
categories: []
featuredImage: ""
featuredImagePreview: ""
toc:
  enable: true
lightgallery: false
---
### 使用 Vite 指定 react 模版创建项目
```bash
  pnpm create vite personal-toolbox --template react
  cd personal-toolbox
  pnpm install
  pnpm run dev

```
### 了解 Vite
1. Vite 是一种新型前端构建工具，可提升前端开发体验；
2. 由两部分组成：一个开发服务器（支持原生ES模块，快速模块热更新）、一套构建指令（Rollup打包代码，预配置，输出高度优化过的静态资源，直接用于生产环境；
3. Vite 也支持多个 .html 作入口点的 多页面应用模式；
4. NPM 预构建提高页面加载速度；
5. Vite 内置了 HMR API 到 Vue 单文件组件和 React Fast Refresh 中，提供即时、准确的更新，无需重新加载页面或清除应用程序状态。不需要手动设置，通过 create-vite 创建应用程序时，所有模版已经预先配置了这些。
6. Vite 天然支持引入 .ts 文件，但是仅转译不执行任何类型的检查，影响Vite 的速度优势。
7. Vite 为Vue3 以及Vue3 jsx 提供了支持插件；
8. 导入CSS 也支持 HMR ；CSS 不需要安装特定的Vite 插件，必须安装相应的预处理依赖；
9. 导入静态资源会返回解析后的 URL；
10. JSON 可以直接导入；支持Glob函数导入；
11. 构建优化
CSS代码分隔，Vite 会自动将一个一步chunk模块中使用到的CSS代码抽取出来生成一个单独的文件，自动通过一个 <link> 标签载入；
Rollup打包后预加载指令自动生成；
异步chunk 加载优化。

