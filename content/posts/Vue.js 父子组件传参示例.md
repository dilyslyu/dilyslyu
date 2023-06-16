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
