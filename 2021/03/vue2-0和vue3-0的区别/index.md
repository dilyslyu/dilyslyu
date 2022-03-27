# Vue2.0和Vue3.0的区别


### 1. 项目目录结构和配置项不同
vue-cli2.0与3.0在目录结构方面，
1. 移除了配置文件目录config，多了.env.production、.env.development，但是配置都差不多
2. 另外还新增了vue.config.js，可以进行跨域域名配置
3. 还移除了静态文件夹static，新增了public文件夹，而且把index.html文件移动到了public文件夹里面，

### 2. 渲染
Vue2.x 使用的Virtual Dom实现的渲染
Vue3.0不论是原生的html标签还是vue组件，他们都会通过h函数来判断，如果是原生html标签，在运行时直接通过Virtual Dom来直接渲染，同样如果是组件会直接生成组件代码

### 3. 数据监听
Vue2.x大家都知道使用的是es5的object.defineproperties中getter和setter实现的；
而vue3.0的版本，是基于Proxy进行监听的，其实基于proxy监听就是所谓的lazy by default，可以理解为‘按需监听’，官方给出的诠释是：速度加倍，同时内存占用还减半。

### 4. 按需引入
Vue2.x中new出的实例对象，所有的东西都在这个vue对象上；
而vue3.0中可以用ES module imports按需引入，如：keep-alive内置组件、v-model指令等等。
