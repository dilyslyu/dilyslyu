# DataPicker 日期选择器设置默认显示时间

默认显示当年年份
```HTML
<template>
<div>
    <el-date-picker
      v-model="value"
      type="year"
      placeholder="选择年">
    </el-date-picker>
</div>
</template>
<script>
export default {
    data (){
        return{
            value：new Data().getFullYear().toString(),
        }
    }
}
</script>

```

