# vue template 绑定事件时是否加括号

1. 加括号

    需要自定义传参：

    ```javascript
    @click="handleClick(scope.row)"

    ```

2. 不加括号

    ```javascript
    a. 输入框绑定的下拉选项发生改变时
    @change ="handleChange"
    handlechange(val){
        console.log(val)//输入框绑定的值
    }
    b. 子组件抛事件给父组件，父组件中监听事件不加括号，默认传入子组件传入的参数
    c. `el-tree` 组件中的 `node-click` 事件
    @node-click="handleNodeClick"
    handleNodeClick(treeNode){
        console.log(treeNode)
    }

    ```

