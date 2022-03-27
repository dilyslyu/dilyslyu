# v-if 多条件使用按钮闪烁

### 问题描述

#### 由于项目需求多次变动，由原来的一个控制条件变为两个控制条件，使用“&&”连接，最终正确实现了按钮显隐控制，但切换控制条件，按钮显隐会有一个闪烁的过程，先显示后隐藏

大致代码实现如下：

```html
v-if="isEditable&&!isA"
```

### 解决方法

#### 无效方法

```html
<div v-cloak>   
    <el-button v-if="!isA&&isEditable"></el-button>
</div>

<style>
    [v-cloak]{
        display:none !important;
    }
</style>
```

#### 对于需要满足多个条件变量的按钮显示控制，需要根据条件控制优先级，分层次判断

在第一条件不满足的情况下不会渲染符合另外一个条件的部分，但是 `v-if="!isA&&isEditable` 会判断有一个满足条件先显示，两个判断完最终确定显隐

```html
<div v-if="isEditable">   
    <el-button v-if="!isA"></el-button>
</div>
```

