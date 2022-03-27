---
title: el-tabs 添加红点标记
date: 2021-03-31 08:49:10
tags:
---

```bash

<el-tabs >
    <el-tab-pane :key="item.name" v-for="(item,index) in editableTabs" :name= "item.name">
        <span slot="label">
        {{ item.title }}
        <el-badge v-if="is-dot" is-dot></el-badge>
    </span>
    </el-tab-pane>
</el-tabs >

```

tab组件嵌入el-badge时获取到了数值，但是el-badge现实的还是初始值，没有及时更新，点击tab页后，数值才更新。
解决方法：
在获取到num值之后，加上以下一行代码：

```bash

this.$children[0].$children[0].forceUpdate()

```
