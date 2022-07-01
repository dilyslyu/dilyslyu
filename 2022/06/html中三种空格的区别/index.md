#  Html中三种空格的区别

### 不同空格符号的区别及含义

1. &nbsp; 半角的不断行的空白格（推荐使用）；这是我们使用最多的空格，也就是按下 space 键产生的空格。在 html 中，如果你用空格键产生此空格，空格是不会累加的（只算一个），要是用 html 实体表示才可累加。该空格占据宽度受字体影响明显而强烈。在 inline- block 布局中会搞些小破坏，在两端对齐布局中又是不可少的元素。
2. &ensp; 半角的空格；此空格有个相当稳健的特性，就是其占据的宽度正好是1/2个中文宽度，而且基本上不受字体影响。
3. &emsp; 全角的空格；此空格也有个相当稳健的特性，就是其占据的宽度正好是1个中文宽度，而且基本上不受字体影响。

### 示例

```html
<template>
  <div
  v-for = "(item,index) of list"
  :key = 'index'
  v-html = 'formatName(item.name)'
  ></div>
</template>
<script>
  methods:{
    // 名字是两个中文或三个中文，两个中文的名字需要加空格和三个中文对齐
    formatName(val){
      if(!val || val.length >2){
        return val
      }
      return `<span>${val,substring(0,1)}</span>&emsp;<span>${val.substring(1)}</span>`
    }
  }
</script>

```

