---
title: 结合localStorage解决页面刷新数据丢失问题
date: 2020-06-09 15:08:56
tags:
---
将需要保存在vuex中的数据，同时保存在localStorage，并在store.js中写入一下代码：

```
for (var item in state){
    localStorage.getItem(item)?state[item]=JSON.parse(localStorage.getItem(item)):false;
}
```
