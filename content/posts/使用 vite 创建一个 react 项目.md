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
2. 由两部分组成：一个开发服务器（支持原生ES模块，快速模块热更新）、一套构建指令（Rollup打包代码，预配置，输出高度优化过的静态资源，直接用于生产环境。
3. Vite 也支持多个 .html 作入口点的 多页面应用模式