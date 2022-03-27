---
title: vue 中扩展运算符 ... (三个点)
date: 2022-03-04 15:57:10
tags:
---
### 扩展运算符

对数组和对象而言，就是将运算符后面的变量里东西每一项拆下来

#### （一）操作数组

```javascript

// 1.把数组中的元素孤立起来
let iArray = ['1', '2', '3'];
console.log(...iArray);
// 打印结果  1 2 3

      
// 2.在数组中添加元素
let iArray = ['1', '2', '3'];
console.log(['0', ...iArray, '4']);
// 打印结果  ["0", "1", "2", "3", "4"]

      
// 3.在数组中删除元素（取出一个元素）
// 与结构赋值的结合
// 如果将扩展运算符用于数组赋值，只能放在参数的最后一位，否则会报错。
const [first, ...rest] = [1, 2, 3, 4, 5];
console.log(first);　　// 打印结果 1
console.log([...rest]);　　// 打印结果 [2, 3, 4, 5]

const [one, ...last] = ["foo"];
console.log(one);　　// 打印结果 foo
console.log([...last]);　　// 打印结果 []

      
// 4.数组的合并
// ES6 的写法
var arr1 = [0, 1, 2];
var arr2 = [3, 4, 5];
arr1.push(...arr2);
console.log(arr1); // 打印结果 [0, 1, 2, 3, 4, 5]
// 推荐使用写法
console.log([...arr1, ...arr2]); // 打印结果 [0, 1, 2, 3, 4, 5]

// 5.将字符串转成数组
let iString = 'zhongguoren';
console.log([...iString]); // 打印结果 ["z", "h", "o", "n", "g", "g", "u", "o", "r", "e", "n"]

// 6.Map 和 Set 结构， Generator 函数
let map = new Map([
  [1, 'one'],
  [2, 'two'],
  [3, 'three'],
]);
let arr = [...map.keys()];
console.log(arr);
// 打印结果 [1, 2, 3]
 
// 7.当做参数传递和直接传数组的区别
iClick4() {
    let iArray = ['1', '2', '3'];
    //注意传的时候，就要三个点
    this.hanshu(...iArray);
},
hanshu(...iArray) {
    let ooo = 1;
    console.log(...iArray);
    // 打印结果 1 2 3
},
        
// 8.求出最大值
let iArray = [1, 2, 3, 99, 44, 66, 21, 85, 77];
let ooo = Math.max(...iArray);
console.log(ooo);
// 打印结果 99

// 9.如果对没有iterator接口的对象，使用扩展运算符，将会报错。
let obj = {
  name: 'zhh',
  age: '20'
}
console.log([...obj]);

```

#### （一）操作对象

```javascript

// 1.添加一个属性
let a = {age: 18, id: 10};
let c = {name: 'zhh', ...a};
console.log(c);    
// 打印结果  {name: "zhh", age: 18, id: 10}

// 2.修改一个属性
let a = {name: 'zhh', age: 18, id: 10};
let c = {...a, name: 'zhh1'};
console.log(c);    
// 打印结果  {name: "zhh1", age: 18, id: 10}

// 3.删除一个属性（拿出属性或者对象）
let a = {name: 'zhh', age: 18, id: 10};
let {name, ...c} = a;
console.log(name, c);    
// 打印结果 zhh {age: 18, id: 10}

```
