# JS 中 map() 是否会改变原数组

### 实际应用有如下总结

 只有当 arr 中元素为基本数据类型时，map 方法才不会改变原始数据； arr 为引用类型时，还是会改变原数组的。

#### 1.不改变原数组

```javascript
let arr1 = [9,2,3]
let arrNew =arr1.map(item => item*2)
console.log(arr1,arrNew)//[9, 2, 3],[18, 4, 6]

let arr2 = [9,2,3]
let arrNew2 =arr2.map(item => {
    item = item*2 
    return item
    })
console.log(arr2,arrNew2)//[9, 2, 3] ,[18, 4, 6]

```

#### 2.改变原数组

```javascript
let arr3 = [{'n':1,'m':'1'},{'n':2,'m':'2'},{'n':3,'m':'3'}]
let arrNew3 =arr3.map(item => {
    item.n = item.m*2 
    return item
    })
console.log(arr3,arrNew3)
/* arr3
0: {n: 2, m: '1'}
1: {n: 4, m: '2'}
2: {n: 6, m: '3'}
*/

/* arrNew3
0: {n: 2, m: '1'}
1: {n: 4, m: '2'}
2: {n: 6, m: '3'}
*/

let arr3 = [{'n':1,'m':'1'},{'n':2,'m':'2'},{'n':3,'m':'3'}]
let arrNew3 =arr3.map(item => {item.k = item.m*2 
return item})
console.log(arr3,arrNew3)
/* arr3
0: {n: 1, m: '1', k: 2}
1: {n: 2, m: '2', k: 4}
2: {n: 3, m: '3', k: 6}
length: 3
[[Prototype]]: Array(0)
*/

/* arrNew3
0: {n: 1, m: '1', k: 2}
1: {n: 2, m: '2', k: 4}
2: {n: 3, m: '3', k: 6}
length: 3
[[Prototype]]: Array(0)
*/

```

#### 3.避免改变原数组的方法

通过一个新的对象去接受每一个元素，修改后，返回该对象

```javascript
let arr3 = [{'n':1,'m':'1'},{'n':2,'m':'2'},{'n':3,'m':'3'}]
let arrNew3 =arr3.map(item => {
    let obj = {...item,h:'66'}
    return obj
})
console.log(arr3,arrNew3)

/* arr3
(3) [{…}, {…}, {…}]
0: {n: 1, m: '1'}
1: {n: 2, m: '2'}
2: {n: 3, m: '3'}
*/

/* arrNew3
(3) [{…}, {…}, {…}]
0: {n: 1, m: '1', h: '66'}
1: {n: 2, m: '2', h: '66'}
2: {n: 3, m: '3', h: '66'}
*/

let arr3 = [{'n':1,'m':'1'},{'n':2,'m':'2'},{'n':3,'m':'3'}]
let arrNew3 =arr3.map(item => {
    let obj = {...item,h:'66'}
    obj.k = obj.m*2 
    return obj
})
console.log(arr3,arrNew3)

/* arr3
(3) [{…}, {…}, {…}]
0: {n: 1, m: '1'}
1: {n: 2, m: '2'}
2: {n: 3, m: '3'}
*/

/* arrNew3
(3) [{…}, {…}, {…}]
0: {n: 1, m: '1', h: '66', k: 2}
1: {n: 2, m: '2', h: '66', k: 4}
2: {n: 3, m: '3', h: '66', k: 6}
*/

```

