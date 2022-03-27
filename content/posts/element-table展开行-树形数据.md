---
title: element table展开行+树形数据+特殊列插入
date: 2021-04-02 17:48:05
tags:
---

```HTML
<el-table
    :data="tableData"
    style="width: 100%;margin-bottom: 20px;"
    row-key="id"
    :expqnd-row-keys = "expands" 
    :tree-props="{children: 'children'}">
<!-- 设置expqnd-row-keys默认展开第一行 -->
    <el-table-column
      prop="date"
      label="日期"
      sortable
      width="180">
    </el-table-column>
    <el-table-column
      prop="name"
      label="姓名"
      sortable
      width="180">
    </el-table-column>
    <el-table-column
      label="地址">
<!-- table展开区域渲染，在每个展开区地址列插入一个输入框 -->
      <template slot-scope="scope">
        <el-select
          v-if=“scope.row.name
          v-model="scope.row.list"
          no-data-text="可在输入框内输入多项内容（输入的内容是一个list列表）"
          multiple
          filterable
          allow-create
          default-first-option
          placeholder="请输入内容"
         ></el-select>
      </template>
    </el-table-column>
  </el-table>

  ```

  ```JavaScript

  expands:["1"],

  tableData: [
          {
          id: 1,
          date: '2016-05-02',
          children:[
            {id:11,name:"小王"，map:[]},
            {id:12,name:"小利"，map:[]},
          ]
          }, 
          {
          id: 2,
          date: '2016-05-04',
          children:[
            {id:21,name:"小王"，map:[]},
            {id:22,name:"小利"，map:[]},
          ]
          },
          {
          id: 3,
          date: '2016-05-01',
          children: [{
              id: 31,
              date: '2016-05-01',
              name: '王小虎',
              map: []
            }]
        }]


        ```
#### 重点在于数据结构的设计：
1. 最外层和展开行 `childre` 里面都要有 `id` ；
2. 使用 `template` 对展开行插入特殊列。