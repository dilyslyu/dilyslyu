# vue template 使用


### `template`的作用是模板占位符，可帮助我们包裹元素，但在循环过程当中，template不会被渲染到页面上

### 使用场景

1. 若不想额外增加一个div，可以使用template来实现

    ```html
    <template v-for="(item, index) in list" :key="item.id">
                    <div>{{item.text}}--{{index}}</div>
                    <span>{{item.text}}</span>
                </template>
    ```

2. 实战

```html

<el-table>
<el-table-column>
<template slot-scope="scope">
<div v-if="scope.row.mark===1">aaa</div>
<div v-else>{{scope.row.itemData}}</div>
</template>
</el-table-column>
</el-table>

```

备注：使用一个`template`包裹两个`div`，而不能直接用两个`template`且在其标签里用`v-if`、`v-else`

