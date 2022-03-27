# 监听页面路由变化刷新页面


#### 需求背景

当页面列表跳转详情页需要携带多个参数，当再返回列表页重新进入详情页时，任何一个参数发生变化都要刷新页面请求数据

#### 实现方式

通过监听路由变化，发起请求刷新页面

```javascript
watch:{
    $route(){
        if(this.$route.name === "CurrentPageName"){ //判断点击的是当前页面
            this.refreshData()
        }
    }
}

// 在data外面定义的属性和方法通过$options可以获取和调用,例如当前页面组件 name
watch:{
    $route(){
        if(this.$route.name === this.$options.name){
            this.refreshData()
        }
    }
}
```

