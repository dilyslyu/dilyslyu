---
title: el-tabs 选中状态下划线不显示问题
date: 2021-04-15 09:37:25
tags:
---
#### 问题描述

每个 tabName 是唯一的，后端没有提供我唯一的id，错误用法如下：

```HTML

<el-tabs v-model="activeName">
    <el-tab-pane 
        v-for="(item,tabIndex) in totalTabs"
        :key="tabIndex"
        :name="tabIndex"
        :label="item.tabName"
    >
    </el-tab-pane>
</el-tabs>
```

导致的问题，默认第一个 tabName 选中状态，对应的 `active-bar width:138px; translate(0)`,
点击其他 tabName ,对应的 `active-bar width:0px; translate(158)`,下划线不显示

#### 解决方法：name不能为`index`

1. 若后端提供有每个 tabName 对应的唯一id，

```HTML

<el-tabs v-model="activeName">
    <el-tab-pane 
        v-for="item in totalTabs"
        :key="item.id"
        :name="item.id"
        :label="item.tabName"
    >
    </el-tab-pane>
</el-tabs>
```

在 data 初始化数据中定义 `activeNAme:"0"`,默认选择第一个 tabName 。
2. 若后端没有提供 唯一ID ，但 tabName  是唯一的

```HTML

<el-tabs v-model="activeName">
    <el-tab-pane 
        v-for="item in totalTabs"
        :key="item.id"
        :name="item.tabName"
        :label="item.tabName"
    >
    </el-tab-pane>
</el-tabs>
```

在 data 初始化数据中定义 `activeName:""`,
在 methods 初始化查询方法中，对 activeName 赋值一个默认值 `this.activeName = totalTabs[0].tabName` 。
