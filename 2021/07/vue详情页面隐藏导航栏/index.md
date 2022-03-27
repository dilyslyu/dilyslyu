# vue详情页面隐藏导航栏

### 需求：点击进入详情页面需要隐藏导航栏和底部菜单栏

使用meta在路由配置以下信息：

```javascript
routes: [
    //在首页里显示导航
    { path: '/', component: index, meta: { navShow: true}, name: 'index' },
    //在详情页面隐藏导航
    { path: '/detail', component: detail, meta: { navShow: false}, name: 'detail' },
  ],

```

在导航组件里:

```javascript
<v-nar v-show="$route.meta.navShow"></v-nar>

```

### 实例

store/modules/app.js

```javascript
const state ={
    language: 'zh_CN,
    ifCollapse:false
}
const mutations = {
    setlanguage: (state,language)=>{
        state.language =language
    },
    switchCollapse: state=>{
        state.ifCollapse = !state.ifCollapse
    }
}
const actions ={
    setLanguage({commit},language){
        commit('setLanguage',language)
    },
    switchCollapse({commit}){
        commit('switchCollapse')
    }
}

export default {
    namespaced:true,
    state,
    mutations,
    actions
}

// 页面中使用
//进入该页面触发store中的方法隐藏侧边导航栏（菜单）
created(){
    this.$store.dispatch('app/switchCollapse')
}

```

