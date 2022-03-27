# el-table格式化el-table-column内容

### 【vue】el-table格式化el-table-column内容

遇到一个需求，一个循环展示的table中的某项，或者某几项需要格式化。对于格式化的方法，主要有`template scope`、`formatter`

#### 一、`template scope`、`v-if`判断

```html
<el-table-column prop="cyxb" label="性别">
    <template slot-scope="scope">
        <span v-if="scope.row.cyxb == 0">男</span>
        <span v-if="scope.row.cyxb == 1">女</span>
    </template>
</el-table-column>

```

#### 二、利用`formatter`、`slot`属性

```html
 <el-table-column prop="xb1" label="成员性别1"  width="120" :formatter="Formatter">

```

```javaScript

filters:{
    Formatter(row, column){
        if(row.xb == 0){
            return "男"
        }else if(row.xb == 1){
            return "女"
        }
    }
}

```

备注：`filters`过滤器与`methods`同级

#### 三、将两种方法结合起来，使用 `slot` ，自定义 `formatter`

```html

<el-table-column
    v-for="column in cbdksTableColumns"
    :prop="column.field"
    :label="column.label"
    sortable="custom"
    :key="column.field"
    min-width="200"
>
   <template slot-scope="scope">
        <div v-if="column.field == 'cyxb'">
            <span v-html="xbFormatter(scope.row.cyxb, scope.column.property)"></span>
        //将表格数据格式化后，再用 template + v-html 展示出来
        </div>
       //<div v-else-if="column.field == 'qqfs'">中间还可以加好多判断，从此针对某列的值进行格式化。
       <div v-else>
           {{ scope.row[scope.column.property] }}//千万不要忘啦！！！
       </div>
   </template>
</el-table-column>


```

```javascript

//之前的代码取数据比较复杂，简化代码，便于理解。
filters:{
    xbFormatter(value, row) {
        //性别
        let cyxbvalue = value;
        if (cyxbvalue == null || cyxbvalue == "" || cyxbvalue == undefined) {
            return cyxbvalue;
        } else {
            let dycyxb = this.xbOptions.filter((item) => item.value === cyxbvalue);//filter过滤方法（看自己的情况、需求）
            return dycyxb[0].label;//rerun的内容即为要在表格中显示的内容
        }
    },

}


```

备注：此处xbOptions是调用后台接口返回的数据，组织结构为

```javascript
this.xbOptions.push({ label: mj.mjmc, value: mj.mjz });
```

#### 四、对表格中的多行金额列进行格式化，保留两位小数

```html
 <!-- 其他列根据表头数据 tableHeadConfig 正常渲染，数值通过 `:prop`动态绑定， tableHeadConfig 数据中的prop的值是 tableData 中的item的key，即每列的prop值绑定在table中 -->
                <el-table-column 
                v-else
                :key="index"
                show-overflow-tooltip
                :prop="config.prop"
                :label="config.label"
                :width="config.width?config.width : ''"
                >
                    <template slot-scope = "scope">
                        <span>{{ scope.row[scope.column.property] | formateMoney }}</span>
                    </template>
                </el-table-column>
```

```javascript
import cash from cash.js;
filters:{
    formateMoney(num){
        return cash.formatDold(num);
    }
}
```

```javascript

//cash.js
//把金额千分位展示
//params: num 传入的待format的金额，保留两位小数
import numeral from 'numeral'
function formatGold(num){
    if(typeof num === 'object'){//null时返回空
        return ''
    }
    return numeral(num).format('0,0.00')
}
```

