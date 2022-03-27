---
title: node.js 里面设置process.env.PORT的值
date: 2020-03-24 16:56:01
tags:
---
### 1.linux环境下：

```$ PORT=1234 node app.js```

使用该命令每次都需要重新设置，如果想设置一次永dao久生效，使用下面的命令。
```export PORT=1234```
```node app.js```
### 2.windows下面按照顺序这样进行：
```set PORT=1234```
```node app.js```

### 具体问题
- 运行项目默认运行在1024端口
DONE  Compiled successfully                                                
App running at:
  -Local:   http://localhost:1024/ 
  -Network: http://192.168.50.38:1024/

- vue.config.js
```const port = process.env.port || process.env.npm_config_port || 80 // 端口```
- 设置修改nodejs端口号
```export PORT=6680```
```node vue.config.js```
- 成功修改运行端口号
App running at:
  -Local:   http://localhost:6680/ 
  -Network: http://192.168.50.38:6680/