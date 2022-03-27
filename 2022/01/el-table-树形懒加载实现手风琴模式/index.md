# el-table 树形懒加载实现手风琴模式


```html
<el-table
    ref = "tableRef"
    :data="tableData"
    :expand-row-keys="expands"
    style="width: 100%"
    row-key="id"
    border
    lazy
    :load="load"
    :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
    @expand-change="expandChange">
    <el-table-column
      prop="date"
      label="日期"
      width="180">
    </el-table-column>
    <el-table-column
      prop="name"
      label="姓名"
      width="180">
    </el-table-column>
    <el-table-column
      prop="address"
      label="地址">
    </el-table-column>
  </el-table>

```

```javascript
tableData: [{
          id: 1,
          date: '2016-05-02',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1518 弄'
        }, {
          id: 2,
          date: '2016-05-04',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1517 弄'
        }, {
          id: 3,
          date: '2016-05-01',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1519 弄',
          hasChildren: true
        }, {
          id: 4,
          date: '2016-05-03',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1516 弄'
        }]

methods: {
      load(tree, treeNode, resolve) {
        setTimeout(() => {
          resolve([
            {
              id: 31,
              date: '2016-05-01',
              name: '王小虎',
              address: '上海市普陀区金沙江路 1519 弄'
            }, {
              id: 32,
              date: '2016-05-01',
              name: '王小虎',
              address: '上海市普陀区金沙江路 1519 弄'
            }
          ])
        }, 1000)
      },
      //设置列表每次只能展开相同 code 的行
      expandChange(row,expanded){
          if(!expanded){//点击的当前行已经展开了，就不需要再点击展开
              return
          }
          //点击的行未展开时，需要对列表中其他展开和收起的行进行判断，code 不同要收起，相同保持展开
          this.tableData.map(item => {
              if(item.code !== row.code){//如果列表中的展开行的 code 与当前点击行的不相同就收起
                  this.$refs.tableRef.toggleRowExpansion(item,false)
              }else{//如果 列表中的展开行的 code 与当前行相同，就展开
                  this.$refs.tableRef.toggleRowExpansion(row,expanded)
              }
          })
      }
    },
```

