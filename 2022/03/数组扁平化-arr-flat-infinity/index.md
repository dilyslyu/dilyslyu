# ES6之数组扁平化 arr.flat(Infinity)

### ES6 之数组的flat(Infinity)扁平化，可以实现多维数组转成一维数组

```javascript
let arr1 = [1,2,[3,4]]
arr1.flat()//[1, 2, 3, 4]

var arr2 = [1, 2, [3, 4, [5, 6]]];
arr2.flat();
// [1, 2, 3, 4, [5, 6]]
 
var arr3 = [1, 2, [3, 4, [5, 6]]];
arr3.flat(2);
// [1, 2, 3, 4, 5, 6]
 
//使用 Infinity 作为深度，展开任意深度的嵌套数组
arr3.flat(Infinity); 
// [1, 2, 3, 4, 5, 6]
```

### flat() 方法会移除数组中的空项

```javascript
var arr4 = [1, 2, , 4, 5];
arr4.flat();
// [1, 2, 4, 5]
```

### For Example

#### 将数组var arr = [ [1, 2, 2], [3, 4, 5, 5], [6, 7, 8, 9, [11, 12, [12, 13, [14] ] ] ], 10];扁平化并去除其中重复数据，最终得到一个升序且不重复的数组

Array.from 转换为数组\ new Set 数组去重\ sort 数组或对象某个属性排序

```javascript
Array.from(new Set(arr.flat(Infinity))).sort((a, b)=> { return a-b })
```

