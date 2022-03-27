---
title: async/await语法糖
date: 2021-12-23 17:27:49
tags:
---
### async/await是一个很重要的语法糖，他的作用是用同步的方式，执行异步操作

#### async/await用法

async/await的用处就是：用同步方式，执行异步操作

比如我现在有一个需求：先请求完接口1，再去请求接口2

```javascript
function request(num) { // 模拟接口请求
  return new Promise(resolve => {//Promise
    setTimeout(() => {
      resolve(num * 2)
    }, 1000)
  })
}

request(1).then(res1 => {
  console.log(res1) // 1秒后 输出 2

  request(2).then(res2 => {
    console.log(res2) // 2秒后 输出 4
  })
})

```

或者我现在又有一个需求：先请求完接口1，再拿接口1返回的数据，去当做接口2的请求参数

```javascript
request(5).then(res1 => {
  console.log(res1) // 1秒后 输出 10

  request(res1).then(res2 => {
    console.log(res2) // 2秒后 输出 20
  })
})

```

其实这么做是没问题的，但是如果嵌套的多了，不免有点不雅观，这个时候就可以用async/await来解决了

```javascript
async function fn () {
  const res1 = await request(5)
  const res2 = await request(res1)
  console.log(res2) // 2秒后输出 20
}
fn()

```

还是用刚刚的例子
需求一：

```javascript
async function fn () {
  await request(1)
  await request(2)
  // 2秒后执行完
}
fn()

```

需求二：

```javascript
async function fn () {
  const res1 = await request(5)
  const res2 = await request(res1)
  console.log(res2) // 2秒后输出 20
}
fn()

```

其实就类似于生活中的排队，咱们生活中排队买东西，肯定是要上一个人买完，才轮到下一个人。而上面也一样，在async函数中，await规定了异步操作只能一个一个排队执行，从而达到用同步方式，执行异步操作的效果，这里注意了：await只能在async函数中使用，不然会报错哦

刚刚上面的例子await后面都是跟着异步操作Promise，那如果不接Promise会怎么样呢？

```javascript
function request(num) { // 去掉Promise
  setTimeout(() => {
    console.log(num * 2)
  }, 1000)
}

async function fn() {
  await request(1) // 2
  await request(2) // 4
  // 1秒后执行完  同时输出
}
fn()

```

可以看出，如果await后面接的不是Promise的话，有可能其实是达不到排队的效果的
说完await，咱们聊聊async吧，async是一个位于function之前的前缀，只有async函数中，才能使用await。那async执行完是返回一个什么东西呢？

```javascript
async function fn () {}
console.log(fn) // [AsyncFunction: fn]
console.log(fn()) // Promise {<fulfilled>: undefined}

```

可以看出，async函数执行完会自动返回一个状态为fulfilled的Promise，也就是成功状态，但是值却是undefined，那要怎么才能使值不是undefined呢？很简单，函数有return返回值就行了

```javascript
async function fn (num) {
  return num
}
console.log(fn) // [AsyncFunction: fn]
console.log(fn(10)) // Promise {<fulfilled>: 10}
fn(10).then(res => console.log(res)) // 10

```

可以看出，此时就有值了，并且还能使用then方法进行输出

#### 总结

await只能在async函数中使用，不然会报错
async函数返回的是一个Promise对象，有无值看有无return值
await后面最好是接Promise，虽然接其他值也能达到排队效果
async/await作用是用同步方式，执行异步操作

async/await是一种语法糖，那就说明用其他方式其实也可以实现他的效果，怎么去实现async/await，用到的是ES6里的迭代函数——generator函数。
