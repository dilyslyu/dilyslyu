---
title: element input 远程搜索
date: 2021-04-08 18:51:53
tags:
---

```HTML
<template>
<div>
    <el-autocomplete
        v-model="state"
        :fetch-suggestions="querySearchAsync"
        placeholder="请输入内容"
        @select="handleSelect"
    ></el-autocomplete>
</div>
</template>
<script>
export default {
    data (){
        return{
            state: "",
            restaurants: [],
        }
    },
    methods: {
        
        // 调用后端接口，获取远程搜索内容
       async querySearchAsync(queryString, cb) {
        var restaurants = await getSubjectInfo();
            // 输入框下拉选项显示内容自定义：拼接name 和 code 
        restaurants.forEach(item => {
            item.value = item.name + "\xao\xao\xao" + item.code;
        });

        // 调用过滤方法对输入的字符串进行过滤
        var results = queryString ? restaurants.filter(this.createStateFilter(queryString)) : restaurants;
        cb(results);
      },

    //   筛选符合条件的选项
      createStateFilter(queryString) {
        return (state) => {
          return (state.value.toLowerCase().indexOf(queryString.toLowerCase()) >= 0);
        };
      },
      handleSelect(item) {
          this.state = item.code
        //   选择之后更新输入框绑定的数据，把 code 绑定在 state 输入框中
        console.log(item);
      }
    }
}
</script>
```
