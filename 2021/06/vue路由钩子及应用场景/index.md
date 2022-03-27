# Vue路由钩子及应用场景

### 一、路由钩子语法

在vue-router的官方文档中, 将路由钩子翻译为导航守卫

#### （一）全局守卫(全局路由钩子)

使用 router.beforeEach 注册一个全局前置守卫：

```javascript
const router = new VueRouter({ ... })

router.beforeEach((to, from, next) => {
  // ...
  next()
})
```

每个守卫方法接受三个参数:

1. `to`: Route: 即将要进入的目标 路由对象
2. `from`: Route: 当前导航正要离开的路由
3. `next`: Function: 一定要调用该方法来 `resolve` 这个钩子。执行效果依赖 `next` 方法的调用参数

注意:使用全局路由钩子, 一定要调用next()!!!

#### （二）路由独享的守卫(路由内钩子)

在路由配置上直接定义 `beforeEnter` 守卫

```javascript
const router = new VueRouter({
  routes: [
    {
      path: '/foo',
      component: Foo,
      beforeEnter: (to, from, next) => {
        // ...
      }
    }
  ]
})

```

这些守卫与全局前置守卫的方法参数是一样的。

#### （三）组件内的守卫(组件内钩子)

在路由组件中直接定义一下路由导航守卫:

`beforeRouteEnter`
`beforeRouteUpdate` (2.2 新增)
`beforeRouteLeave`

```javascript
const Foo = {
  template: `...`,
  beforeRouteEnter (to, from, next) {
    // 在渲染该组件的对应路由被 confirm 前调用
    // 不！能！获取组件实例 `this`
    // 因为当守卫执行前，组件实例还没被创建
  },
  beforeRouteUpdate (to, from, next) {
    // 在当前路由改变，但是该组件被复用时调用
    // 举例来说，对于一个带有动态参数的路径 /foo/:id，在 /foo/1 和 /foo/2 之间跳转的时候，
    // 由于会渲染同样的 Foo 组件，因此组件实例会被复用。而这个钩子就会在这个情况下被调用。
    // 可以访问组件实例 `this`
  },
  beforeRouteLeave (to, from, next) {
    // 导航离开该组件的对应路由时调用
    // 可以访问组件实例 `this`
  }
}

```

### 二、路由钩子在实际开发中的应用场景

路由钩子在实际的开发过程中使用较少, 我在实际的项目中只在组件内使用过 `beforeRouteLeave`, 使用场景分别为一下三类情况:

#### (一) 清除当前组件中的定时器

当一个组件中有一个定时器时, 在路由进行切换的时候, 可使用beforeRouteLeave将定时器进行清楚, 以免占用内存:

```javascript
beforeRouteLeave (to, from, next) {
  window.clearInterval(this.timer) //清楚定时器
  next()
}

```

#### (二) 当页面中有未关闭的窗口, 或未保存的内容时, 阻止页面跳转

如果页面内有重要的信息需要用户保存后才能进行跳转, 或者有弹出框的情况. 应该阻止用户跳转

```javascript
 beforeRouteLeave (to, from, next) {
 //判断是否弹出框的状态和保存信息与否
 if (this.dialogVisibility === true) {
    this.dialogVisibility = false //关闭弹出框
    next(false) //回到当前页面, 阻止页面跳转
  }else if(this.saveMessage === false) {
    alert('请保存信息后退出!') //弹出警告
    next(false) //回到当前页面, 阻止页面跳转
  }else {
    next() //否则允许跳转
  }
}

```

```javascript
beforeRouteLeave (to, from, next) {
    // 导航离开该组件的对应路由时调用
    // 可以访问组件实例 `this`
    const answer = window.confirm('Do you really want to leave? you have     
      unsaved changes!')
    if (answer) {
       next()
    } else {
        next(false)
    }
  }

  import {Component, Vue} from 'vue-property-decorator';
  Component.registerHooks([
        'beforeRouteLeave',
    ]);
```

#### (三) 保存相关内容到Vuex中或Session中

当用户需要关闭页面时, 可以将公用的信息保存到session或Vuex中

```javascript
 beforeRouteLeave (to, from, next) {
    localStorage.setItem(name, content); //保存到localStorage中
    next()
}
```

