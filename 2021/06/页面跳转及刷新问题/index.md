# 页面跳转及刷新问题

### vue 页面跳转的三种方式

1. this.$router.push
2. this.$router.go
3. this.$router.replace

#### this.$router.push()

导航到不同的URL，使用`router.push`方法。这个方法会向`history`栈添加一个新的记录，所以点击浏览器的后退按钮会回到之前的URL。
该方法的参数可以是一个字符串路径，或者一个描述地址的对象。例如：

```javascript
//字符串
router.push('home')
//对象
router.push({path:'home'})
//命名的路由
router.push({name:'user',params:{userId:'112'}})
//带查询参数，变成 `/register?plan=private`
router.push({path:'register',query:{lian:'private'}})

```

点击`<router-link :to="..."></router-link>`时，这个方法会在内部调用。所以点击`<router-link :to="...">`等同于调用`router.push(...)`

```javascript
//声明式路由跳转
<router-link :to="..."></router-link>
//编程式路由跳转
router.push(...)
```

#### this.$router.go

这个方法的参数是一个整数，意思是在`history`记录中向前或者后退多少步。参数为0时会重新加载页面，但会有短暂白屏。

```javascript
methods:{
    onClickLeft(){
        this.$router.go(-2)
    }
}

```

#### this.$router.replace

跟 `$router.push`很像，唯一的不同就是他不会向`history`栈中添加新记录，而是跟他的方法名一样替换掉当前的`history`记录。

```javascript
//声明式路由跳转
<router-link :to="..." replace></router-link>
//编程式路由跳转
router.replace(...)
```

`router.replace`需点击两次浏览器返回键返回的问题及解决方案：
三个页面a,b,c。页面a`push`跳转至b,b `push`跳转到c ,c使用`replace("b")`回到b，然后点击b 页面的返回键，点击两次才能回到a 页面。
第一次点击并不是没反应，而是页面返回到了首次的b 页面。就是说在c页面使用`replace`替换掉的是c页面的路由，c 页面之前的b页面历史记录还存在。

解决方法为在 `history`记录中后退一页：

```javascript
//c 页面跳转 b 页面时
methods:{
    onClickLeft(){
        this.$router.replace('b')
        this.$router.go(-1)
    }
}

```

### router.push 使用关注点

1. `name`与`params`结合使用

    ```javascript
    this.$router.push({
        name:'plate',
        params:{id:id}
    })
    //页面获取参数方式
    this.$route.params.id
    //router.js配置
    {
        path:'plate/:id',
        name:'plate',
        component:()=>
        import ('./components/plate.vue')
    }

    ```

2. `path`与`query`结合使用，就算刷新页面参数也会存在

    ```javascript

    this.$router.push({
    path:'/store-detail',
    query:{store_id:store_id,appid:appid}
    })

    //页面获取参数方式
    this.$route.query.appid
    //router.js配置
    {
        path:'/store-detail',
        name:'store-detail',
        component:()=>
        import ('./components/detail.vue')
    }

    ```

3. vue 传参方式及区别p
query
params+动态路由传参

区别：
1.1 query 通过 path 切换路由，params 通过 name 切换路由
2.2 query 传参的 URL 展现方式：`/detail?id=1&user=112` , params 动态路由传参的 URL 展现方式：/detail/123
3.3 params 动态路由传参一定要在路由中定义参数，否则就是空白页面或者页面刷新参数就不惨在了。

```javascript
{
    path:'/detail/:id',
    name:'Detail',
    component:Detail
}
```

### 实战问题

问题描述：

1. 使用`this.$router.push ({path:'',query:''})`，从列表页跳转到详情页，再从详情页跳转到列表页，列表页不刷新且保留上次查询条件

    解决方法：在列表页的 vue 文件中加 `name:List`,这里的 name 要和路由配置中的保持一致，这样从详情页跳转会列表页，列表页就不刷新了。

2. 从列表页跳转到详情页，再从详情页跳转到列表页，列表页未刷新，点击列表页中某一条跳转带详情页，详情页未触发接口，还是上次打开详情页的数据

    解决方法：

    a. 把详情页 vue 文件中定义的 name 去掉，这样再从列表页点击某一条跳转至详情页，页面就会刷新重新触发接口;
    b. 在详情页设置路由监听,监听到路由变化，重新调用初始化方法

    ```javascript
    watch:{
        $route(){
            this.initData()
        }
    }
    ```
3. 从详情页点击“确定”按钮跳转到列表页，列表页刷新；从详情页点击“取消”按钮跳转到列表页，列表页不刷新

解决办法：

第一步：在列表页使用`activated`方法代替`created`方法；
第二步：在列表页的`activated`方法中进行初始化接口调用，添加一个初始化条件（这个条件默认为true）；

```javascript
activated(){
    if(!this.$route.query.backFlag){
        this.queryList()
    }
}
```

第三步：在详情页“取消”按钮点击跳转事件中，加一个传参字段`backFlag`值为`true`，实现列表页不刷新。

```javascript
//点击取消按钮
handleCancel(){
    this.$router.push({
        path:'list',
        query:{backflag:true}
    })
}

```

