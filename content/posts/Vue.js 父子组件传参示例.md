---
title: "Vue.js 父子组件传参示例"
subtitle: ""
date: 2023-06-16T15:38:52+08:00
lastmod: 2023-06-16T15:38:52+08:00
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

### 父组件代码

```html
<template>
  <div>
    <!-- 通过自定义属性传递多个值 -->
    <Subassembly :value="doc" :num="num" :arr="arr" :obj="obj" />
  </div>
</template>

<script setup>
  import { ref } from "vue";
  import Subassembly from "./Subassembly.vue";

  // 待传递的值
  const doc = ref("hello");
  const num = ref(123);
  const arr = ref([1, 2, 3]);
  const obj = ref({ a: 1, b: 2 });
</script>
```

### 子组件代码

```html
<template>
  <div>{{ value }} - {{ num }} - {{ arr }} - {{ obj }}</div>
</template>

<script>
  export default {
    props: {
      value: {
        type: String,
        default: "",
      },
      num: {
        type: Number,
        default: 0,
      },
      arr: {
        type: Array,
        default: () => [],
      },
      obj: {
        type: Object,
        default: () => ({}),
      },
    },
  };
</script>
```

使用 props 传递多种类型的数据。在父组件中，我们通过自定义属性将值传递给子组件。在子组件中，我们定义了 props 并指定了它们的类型和默认值。这样，我们就可以在子组件中使用这些传递过来的值了。

要让子组件触发父组件中的事件，$on 方法在 Vue 3 中已经被弃用了，在 Vue 3 中，我们可以使用 emits 选项和 emit 函数来替代 $on 方法。下面是一个简单的代码示例：

父组件代码：

```html
<template>
  <div>
    <!-- 监听子组件触发的自定义事件 -->
    <Subassembly @custom-event="handleCustomEvent" />
  </div>
</template>

<script setup>
  import Subassembly from "./Subassembly.vue";

  // 处理子组件触发的自定义事件
  const handleCustomEvent = (value) => {
    console.log("子组件触发了自定义事件，传递的值为：", value);
  };
</script>
```

子组件代码：

```html
<template>
  <div>
    <button @click="handleClick">点击我触发父组件中的事件</button>
  </div>
</template>

<script setup>
  import { defineEmit } from "vue";

  // 定义 emit 函数
  const emit = defineEmit(["custom-event"]);

  // 点击按钮时触发父组件中的自定义事件
  const handleClick = () => {
    emit("custom-event", "hello");
  };
</script>
```

在上面的代码中，我们在子组件中定义了一个按钮，当点击这个按钮时，会触发一个名为 `handleClick` 的方法。在这个方法中，我们使用 `emit` 函数触发了一个名为 `custom-event` 的自定义事件，并传递了一个值 `'hello'`。

在父组件中，我们监听了子组件触发的 `custom-event` 事件，并定义了一个名为 `handleCustomEvent` 的方法来处理这个事件。当子组件触发这个事件时，父组件中的 `handleCustomEvent` 方法就会被调用，并接收到子组件传递过来的值。
