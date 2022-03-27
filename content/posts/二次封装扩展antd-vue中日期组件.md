---
title: 二次封装扩展antd-vue中日期组件
date: 2020-09-15 19:26:50
tags:
---
#### src/utils/dateUtils.js

```
import moment from 'moment'

/**
 * 表格时间格式化
 * defaultstartValue defaultendValue 可为空
 * startValue endValue 不可为空
 * 
 */
export function dilysData(format, defStartValue ,defEndValue ,start, end) {
    console.log(format)
    console.log(defStartValue)
    console.log(defEndValue)
    console.log(start)
    console.log(end)
    return {
        dateFormat: format,
        defaultstartValue: moment(defStartValue, format),
        defaultendValue: moment(defEndValue, format),
        startValue: moment(start, format),
        endValue: moment(end, format),
    }
}
```

#### src/compinents/HelloWorld.vue

```
<template>
  <div>
    <div>
      <span>开始时间：</span>
      <a-date-picker
        v-model="startValue"
        format="YYYY-MM-DD"
        placeholder="开始日期"
        :default-value="defaultstartValue"
      />
    </div>
    <div>
      <span>结束时间：</span>
      <a-date-picker
        :default-value="defaultendValue"
        v-model="endValue"
        format="YYYY-MM-DD"
        placeholder="结束日期"
      />
      <div>
        <button v-on:click="changeDays">近7天</button>
      </div>
    </div>
  </div>
</template>

<script>
import { dilysData } from "@/utils/dateUtils";
const nowDate = new Date();

export default {
  name: "HelloWorld",
  data() {
    return dilysData(
      "YYYY-MM-DD",
      new Date(nowDate.getTime() - 1 * 24 * 60 * 60 * 1000 + 1000),
      nowDate,
      new Date(nowDate.getTime() - 1 * 24 * 60 * 60 * 1000 + 1000),
      nowDate
    );
  },
  methods: {
    changeDays() {
      console.log("zhixing");
      const obj =  dilysData(
        "YYYY-MM-DD",
        new Date(nowDate.getTime() - 7 * 24 * 60 * 60 * 1000 + 1000),
        nowDate,
        new Date(nowDate.getTime() - 7 * 24 * 60 * 60 * 1000 + 1000),
        nowDate
      );
      this.startValue = obj.startValue;
      this.endValue = obj.endValue;
    },
  },
};
</script>
```
#### app.vue中引入使用

需要注意点： v-model 与 default-value 绑定值与默认值都必须是moment对象。否则控制台会报错
