---
title: vue 项目中页面调用后台数据中的字段，在数据加载完毕之前出现XXXX is  undefined
date: 2021-04-19 19:37:40
tags:
---
#### 问题描述

通过不同的筛选条件，展示不同的页面内容；如在 created 方法中调用接口方法，一进入页面回显数据，展示的内容通过调用接口绑定数据渲染；某写筛选条件下，后端数据为空，页面不渲染，控制台报错： `object.name is undefined`
若 object is undefined ，则 `object.name` 也是 `undefined`  

#### 解决办法

1. 在其父级标签中使用`v-if= 'object'`，也就是说当需要显示的数据存在时才显示。

2. 在 html 中 使用 " && " 符号： `{{object&&object.name}}`

3. 在 `data()` 中设置一个空值或者自定义的值，在数据到达之前显示这个值  `object[{name:"Lily"}]`  

4. 在 methods 某个方法中 使用三目表达式 ：`this.formData = this.rmapData[this.activeName]?this.rmapData[this.activeName]:defaultFormData`  

在 script 里面，`export default` 上面，定义一个全局变量,在后台数据不存在时展示：  

```HTML
const defaultFormData = {
    name: "",
    age:"",
    sex:"1"
}
```
