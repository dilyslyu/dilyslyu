# vue.nextTick()方法的使用

#### 什么是 `vue.nextTick()` ？

1. 获取更新后的DOM的Vue方法：即在下次 DOM 更新循环结束之后执行延迟回调，在修改数据之后立即使用这个方法，获取更新后的 DOM。

2. 当数据更新了，在dom中渲染后，自动执行该函数

    ```javascript
    <template>
    <div class="hello">
        <div>
        <button id="firstBtn" @click="testClick()" ref="aa">{{testMsg}}</button>
        </div>
    </div>
    </template>
    
    <script>
    export default {
    name: 'HelloWorld',
    data () {
        return {
        testMsg:"原始值",
        }
    },
    methods:{
        testClick:function(){
        let that=this;
        that.testMsg="修改后的值";
        console.log(that.$refs.aa.innerText);   //that.$refs.aa获取指定DOM，输出：原始值
        }
    }
    }
    </script>
    

    ```

使用this.$nextTick()

```javascript
methods:{
    testClick:function(){
    let that=this;
    that.testMsg="修改后的值";
    that.$nextTick(function(){
        console.log(that.$refs.aa.innerText);  //输出：修改后的值
    });
    }
}

```

注意：Vue 实现响应式并不是数据发生变化之后 DOM 立即变化，而是按一定的策略进行 DOM 的更新。$nextTick 是在下次 DOM 更新循环结束之后执行延迟回调，在修改数据之后使用 $nextTick，则可以在回调中获取更新后的 DOM

#### 什么时候需要用的Vue.nextTick()？

1. Vue生命周期的created()钩子函数进行的DOM操作一定要放在Vue.nextTick()的回调函数中，原因是在created()钩子函数执行的时候DOM 其实并未进行任何渲染，而此时进行DOM操作无异于徒劳，所以此处一定要将DOM操作的js代码放进Vue.nextTick()的回调函数中。与之对应的就是mounted钩子函数，因为该钩子函数执行时所有的DOM挂载已完成。

    ```javascript
    created(){
        let that=this;
        that.$nextTick(function(){  //不使用this.$nextTick()方法会报错
            that.$refs.aa.innerHTML="created中更改了按钮内容";  //写入到DOM元素
        });
    },

    ```

2. 当项目中你想在改变DOM元素的数据后基于新的dom做点什么，对新DOM一系列的js操作都需要放进Vue.nextTick()的回调函数中；通俗的理解是：更改数据后当你想立即使用js操作新的视图的时候需要使用它

    ```javascript
    <template>
    <div class="hello">
        <h3 id="h">{{testMsg}}</h3>
    </div>
    </template>
    
    <script>
    export default {
    name: 'HelloWorld',
    data () {
        return {
        testMsg:"原始值",
        }
    },
    methods:{
        changeTxt:function(){
        let that=this;
        that.testMsg="修改后的文本值";  //vue数据改变，改变dom结构
        let domTxt=document.getElementById('h').innerText;  //后续js对dom的操作
        console.log(domTxt);  //输出可以看到vue数据修改后DOM并没有立即更新，后续的dom都不是最新的
        if(domTxt==="原始值"){
            console.log("文本data被修改后dom内容没立即更新");
        }else {
            console.log("文本data被修改后dom内容被马上更新了");
        }
        },
    
    }
    }
    </script>
    
    ```

    正确的用法是：vue改变dom元素结构后使用vue.$nextTick()方法来实现dom数据更新后延迟执行后续代码

    ```javascript
        changeTxt:function(){
        let that=this;
        that.testMsg="修改后的文本值";  //修改dom结构
        
        that.$nextTick(function(){  //使用vue.$nextTick()方法可以dom数据更新后延迟执行
            let domTxt=document.getElementById('h').innerText; 
            console.log(domTxt);  //输出可以看到vue数据修改后并没有DOM没有立即更新，
            if(domTxt==="原始值"){
            console.log("文本data被修改后dom内容没立即更新");
            }else {
            console.log("文本data被修改后dom内容被马上更新了");
            }
        });
        },


    ```

3. 在使用某个第三方插件时 ，希望在vue生成的某些dom动态发生变化时重新应用该插件，也会用到该方法，这时候就需要在 $nextTick 的回调函数中执行重新应用插件的方法。

#### Vue.nextTick(callback) 使用原理

Vue是异步执行dom更新的，一旦观察到数据变化，Vue就会开启一个队列，然后把在同一个事件循环 (event loop) 当中观察到数据变化的 watcher 推送进这个队列。如果这个watcher被触发多次，只会被推送到队列一次。这种缓冲行为可以有效的去掉重复数据造成的不必要的计算和DOm操作。而在下一个事件循环时，Vue会清空队列，并进行必要的DOM更新。
当你设置 vm.someData = 'new value'，DOM 并不会马上更新，而是在异步队列被清除，也就是下一个事件循环开始时执行更新时才会进行必要的DOM更新。如果此时你想要根据更新的 DOM 状态去做某些事情，就会出现问题。。为了在数据变化之后等待 Vue 完成更新 DOM ，可以在数据变化之后立即使用 Vue.nextTick(callback) 。这样回调函数在 DOM 更新完成后就会调用
4. 个人理解this.$nextTick()的使用场景
项目的html页面中使用vue和echarts，点击按钮后需要重新渲染echart图标,但是echart却报错：Can't get dom width or height。可以很清楚知道是由于echarts获取不到宽度和高度，我试过使用this.$refs来获取元素的宽高，但还是失败了，所以，我觉得还是dom渲染问题，那么此时快速的解决办法就是使用this.$nextTick()方法。我从上面的使用结果可以知道，this.$nextTick()方法主要是用在随数据改变而改变的dom应用场景中，vue中数据和dom渲染由于是异步的，所以，要让dom结构随数据改变这样的操作都应该放进this.$nextTick()的回调函数中。created()中使用的方法时，dom还没有渲染，如果此时在该钩子函数中进行dom赋值数据（或者其它dom操作）时无异于徒劳，所以，此时this.$nextTick()就会被大量使用，而与created()对应的是mounted()的钩子函数则是在dom完全渲染后才开始渲染数据，所以在mounted()中操作dom基本不会存在渲染问题。

```html
<div class="app">
  <div ref="msgDiv">{{msg}}</div>
  <div v-if="msg1">Message got outside $nextTick: {{msg1}}</div>
  <div v-if="msg2">Message got inside $nextTick: {{msg2}}</div>
  <div v-if="msg3">Message got outside $nextTick: {{msg3}}</div>
  <button @click="changeMsg">
    Change the Message
  </button>
</div>
```

```javascript
new Vue({
  el: '.app',
  data: {
    msg: 'Hello Vue.',
    msg1: '',
    msg2: '',
    msg3: ''
  },
  methods: {
    changeMsg() {
      this.msg = "Hello world."
      this.msg1 = this.$refs.msgDiv.innerHTML
      this.$nextTick(() => {
        this.msg2 = this.$refs.msgDiv.innerHTML
      })
      this.msg3 = this.$refs.msgDiv.innerHTML
    }
  }
})

```

vue中的msg1和msg3显示的数据还是赋值之前的，msg2显示的数据则是赋值之后的。其根本原因是vue中的dom渲染是异步的。
