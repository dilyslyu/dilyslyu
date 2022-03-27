---
title: vue 基础模版
date: 2022-03-09 15:26:27
tags:
---

```html
<template>
<div id = "app">
    <input type="text" id="ipt">
</div>
</template>
<script type = "text/javascript">
export default{
    name:'app',
    components:{},
    props:{},
    data(){
        return{

        }
    },
    computed:{},
    watch:{},
    created(){},
    mounted(){
        let eleIpt = document.getElementById('ipt')
        eleIpt.addEventListener('keyup',debounce(function(){
            console.log(eleIpt.value)
        },600)
        )
        // 手写防抖 用户在输入结束或暂停时，触发 change 事件 keyup（频繁输入和操作）
        // input 搜索如何防抖，如何处理中文输入
        function debounce(fn,delay=500) {
            let timer = null // 闭包变量
            return function (){
                if(timer){
                clearTimeout(timer)
                }
                timer = setTimeout(()=>{
                    fn.apply(this,arguments)
                    timer = null // 被引用的私有变量不能被销毁，增大了内存消耗，造成内存泄漏，解决方法是可以在使用完变量后手动为它赋值为null；
                },delay)
            }
        }

    },
    methods:{}
} 
</script>
<style lang="scss" scoped>

</style>

```
