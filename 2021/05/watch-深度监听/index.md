# watch 深度监听

### Vue.js中 watch(深度监听)

#### 成功实践

在监听复杂数据类型的时候，不能像之前监听普通数据那样写，我们需要使用深度监听

```javascript
export default{
props:{
        tableData: {
            type: Object,
            default: function(){
                return {
                    date:null,
                    data:[]
                };
            }
    }
},
data(){
    return{};
},
watch: {
//监听普通数据的写法
    tableData(newData, oldData) {
    console.log(newData, oldData)
    }
} 

```

最初绑定的时候是不会执行的，要等到改变时才执行监听计算且不能监听到tableData。我们想要一开始就让他最初绑定的时候就执行

```javascript
export default{
    props:{
        printData: {
            type: [Object, String],
            default: '' 
    }
    },
    data(){
    return{};
    },
  watch: {
    tableData: {
    // 表示对象中属性变化的处理函数，这个函数只能叫这个名字
    handler(newData) {
        console.log(newData)
        let resList = []
        let len  = Math.max(newData.inList.length,newData.exList.length)
        for (let i = 0;i<len;i++){
            resList.push(
                {
                    inList:newData.inList[i]||[],
                    exList:newData.exList[i]||[]
                }
            )
        }
        this.tableData.data = resList
    },     
    // 代表在wacth里声明了printData这个方法之后立即先去执行handler方法
      immediate: true,
      deep: true // 表示开启深度监听
    }
  } 
}

```

```javascript
//后端接口返回的数据结构
tableData:{
    date:2021,
    inList:[
        {num:"1",name:"a",money:"768.76"},
        {num:"2",name:"b",money:"768.70"},
        {num:"3",name:"c",money:"768.06"}
    ],
    exList:[
        {num:"1",name:"a",money:"768.76"},
        {num:"2",name:"b",money:"768.70"},
        {num:"3",name:"c",money:"768.06"}
    ]
}
//处理后的数据接口,两个数组重组为一个大的数组,页面表格对这个大的数组`data`进行`V-for`遍历,通过item.inList.num的形式去取值和渲染表格
resList即tableData.data:[
    {inList:{{num:"1",name:"a",money:"768.76"},exList:{num:"1",name:"a",money:"768.76"}},
    {inList:{{num:"2",name:"b",money:"768.70"},exList:{num:"2",name:"b",money:"768.70"}},
    {inList:{{num:"3",name:"c",money:"768.06"},exList:{num:"3",name:"c",money:"768.06"}},
]

```

#### 当我们输入firstName后，wacth监听每次修改变化的新值，然后计算输出fullName。

```javascript
watch: {
    firstName(newName, oldName) {
      this.fullName = newName + ' ' + this.lastName;
    }
  }
```

#### handler方法和immediate属性

这里 watch 的一个特点是，最初绑定的时候是不会执行的，要等到 firstName 改变时才执行监听计算。那我们想要一开始就让他最初绑定的时候就执行改怎么办呢？我们需要修改一下我们的 watch 写法，修改过后的 watch 代码如下：

```javascript
watch: {
  firstName: {
    handler(newName, oldName) {
      this.fullName = newName + ' ' + this.lastName;
    },
    // 代表在wacth里声明了firstName这个方法之后立即先去执行handler方法
    immediate: true
  }
}

```

我们给 firstName 绑定了一个handler方法，之前我们写的 watch 方法其实默认写的就是这个handler，Vue.js会去处理这个逻辑，最终编译出来其实就是这个handler。

#### deep属性

watch 里面还有一个属性 deep，默认值是 false，代表是否深度监听，比如我们 data 里有一个obj属性：

```javascript
<div>
      <p>obj.a: {{obj.a}}</p>
      <p>obj.a: <input type="text" v-model="obj.a"></p>
</div>
 
new Vue({
  el: '#root',
  data: {
    obj: {
      a: 123
    }
  },
  watch: {
    obj: {
      handler(newName, oldName) {
         console.log('obj.a changed');
      },
      immediate: true
    }
  } 
})

```

当我们在在输入框中输入数据视图改变obj.a的值时，我们发现是无效的。受现代 JavaScript 的限制 (以及废弃 Object.observe)，Vue 不能检测到对象属性的添加或删除。由于 Vue 会在初始化实例时对属性执行 getter/setter 转化过程，所以属性必须在 data 对象上存在才能让 Vue 转换它，这样才能让它是响应的。
默认情况下 handler 只监听obj这个属性它的引用的变化，我们只有给obj赋值的时候它才会监听到，比如我们在 mounted事件钩子函数中对obj进行重新赋值：

```javascript
mounted: {
  this.obj = {
    a: '456'
  }
}

```

这样我们的 handler 才会执行，打印obj.a changed。
相反，如果我们需要监听obj里的属性a的值呢？这时候deep属性就派上用场了！

```javascript
watch: {
  obj: {
    handler(newName, oldName) {
      console.log('obj.a changed');
    },
    immediate: true,
    deep: true
  }
} 

```

deep的意思就是深入观察，监听器会一层层的往下遍历，给对象的所有属性都加上这个监听器，但是这样性能开销就会非常大了，任何修改obj里面任何一个属性都会触发这个监听器里的 handler。
优化，我们可以是使用字符串形式监听。

```javascript
watch: {
  'obj.a': {
    handler(newName, oldName) {
      console.log('obj.a changed');
    },
    immediate: true,
    // deep: true
  }
} 

```

这样Vue.js才会一层一层解析下去，直到遇到属性a，然后才给a设置监听函数。

### 注销watch

为什么要注销 watch？因为我们的组件是经常要被销毁的，比如我们跳一个路由，从一个页面跳到另外一个页面，那么原来的页面的 watch 其实就没用了，这时候我们应该注销掉原来页面的 watch 的，不然的话可能会导致内置溢出。好在我们平时 watch 都是写在组件的选项中的，他会随着组件的销毁而销毁。

```javascript
const app = new Vue({
  template: '<div id="root">{{text}}</div>',
  data: {
    text: 0
  },
  watch: {
    text(newVal, oldVal){
      console.log(`${newVal} : ${oldVal}`);
    }
  }
});

```

但是，如果我们使用下面这样的方式写 watch，那么就要手动注销了

```javascript
const unWatch = app.$watch('text', (newVal, oldVal) => {
  console.log(`${newVal} : ${oldVal}`);
})
 
unWatch(); // 手动注销watch

```

app.$watch调用后会返回一个值，就是unWatch方法，你要注销 watch 只要调用unWatch方法就可以了。


