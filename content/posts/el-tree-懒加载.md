---
title: el-tree 懒加载
date: 2021-05-25 16:23:45
tags:
---
除了顶级节点自定义为：全国，其他子节点懒加载,在点击节点时才进行该层数据的获取。

```html
<template>
<el-tree
  :data="treeData"
  :node-key="code"
  :load="loadChildren"
  lazy
  highlight-current
  :props="props"
  accordion
  @node-click="handleNodeClick"
  ref="treeDataRef">
</el-tree>
</template>

<script>
  export default {
    data() {
      return {
       treeData:[],
       code:000,
       props:{
           label:'code',
           children:'children',
           isLeaf:'leaf'
       }
        }
      };
    },
    methods: {
      handleNodeClick(treeData) {
        console.log(treeData.code);
      },
      loadChildren(node,resolve){
          console.log(node.data)
          try{
              if(node.level===0){
                  return resolve([{ code: '全国' }])//自定义一个顶级的全国节点
              }else if(node.level===1){//获取自定义节点下的数据
                const treeData = await queryCodeList({pcode:'111111'})
                resolve(treeData)
              }else{
                const treeData=await queryCodeList({pcode:node.data.code})//此时的code是当前节点node中的data的code
                resolve (treeData)
              }
          }catch(e){
            console.warn(e)
          }
      }
    }
  };
</script>
```
