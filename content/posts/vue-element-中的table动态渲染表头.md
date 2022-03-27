---
title: vue element 中的table动态渲染表头
date: 2021-03-31 13:03:11
tags:
---

1. `table`

    ```HTML

    <el-table :data="tableData" style="width: 100%">
                <el-table-column 
                v-for="(item,index) in labelData"
                :key = index
                :prop="item.prop"
                :label="item.label" 
                ></el-table-column>
            </el-table>

    ```

2. `data`
labelData 中的 prop 是 tableData 中的属性

    ```JavaScript

    labelData:[
            {index:1,label:"日期",prop:'date'},
            {index:2,label:"编号",prop:'code'},
            {index:3,label:"详情",prop:'content'}
            ],
        tableData: [
            {
            date: "2016-05-02",
            code: "王小虎",
            content: "会议地点上海市普陀区金沙江路 1518 弄",
            },
            {
            date: "2021-03-26",
            code: "王小虎",
            content: "地点修改为：上海市普陀区金沙江路 1518 弄",
            },
        ]

    ```

3. 通过 `v-for` 列表渲染表头，v-if条件判断渲染特殊列，没有特殊列的只使用 `v-else`所在的`<el-table-column></el-table-column>`即可

    ```HTML
    <template>
    <div>
        <el-table :data="tabledata" stripe class="iTable" style="width:100%;">
            <!-- 表格序号列和选择列单独列出，其他列条件判断动态渲染表头和 table 数据 -->
            <el-table-column fixed type="selection" width="45"></el-table-column>
            <el-table-column fixed type="index" label="序号" width="45"></el-table-column>
            <!-- 表头动态渲染 -->
            <template v-for="(config,index) in tableHeadConfig">
                <!-- 特殊列 E 添加 slot  -->
                <el-table-column 
                v-if="config.prop==='E'"
                :key="index"
                show-overflow-tooltip
                :prop="config.prop"
                :label="config.label"
                :width="config.width?config.width : ''"
                >
                    <template slot-scope="scope">
                        <span v-if ="scope.row.D==='666'" class="generalstyle">666</span>
                        <span v-if ="scope.row.D==='888'" class="generalstyle disable">888</span>
                    </template>
                </el-table-column>
                <!-- 前三列固定 -->
                <el-table-column 
                v-else-if="config.prop==='A'||config.prop==='B'||config.prop==='C'"
                fixed
                :key="index"
                show-overflow-tooltip
                :prop="config.prop"
                :label="config.label"
                :width="config.width?config.width : ''"
                ></el-table-column>
                <!-- 其他列根据表头数据 tableHeadConfig 正常渲染，数值通过 `:prop`动态绑定， tableHeadConfig 数据中的prop的值是 tableData 中的item的key，即每列的prop值绑定在table中 -->
                <el-table-column 
                v-else
                :key="index"
                show-overflow-tooltip
                :prop="config.prop"
                :label="config.label"
                :width="config.width?config.width : ''"
                ></el-table-column>
            </template>
        </el-table>
    </div>
    </template>
    <script>
    export default {
        data (){
            return{
                tableHeadConfig:[
                    {label:"aa",prop:"A"},
                    {label:"bb",prop:"B",width:100},
                    {label:"cc",prop:"C"},
                    {label:"dd",prop:"D",width:150},
                    {label:"ee",prop:"E"},
                ],
                tableData:[
                    {A:"a1",B:"b1",C:"c1",D:"d1",E:"e1"},
                    {A:"a12",B:"b12",C:"c12",D:"d12",E:"e12"},
                    {A:"a13",B:"b13",C:"c13",D:"d13",E:"e13"},
                ]
            }
        }
    }
    </script>

    <style >
    /* scss中显示和禁用状态样式 */
    .generalstyle{
        background-color:#349f00;
        padding: 2px 8px;
        border-radius: 4px;
        color: #fff;
        font-size: 12px;
        &.disable{
            background-color: #c9c9c9;
        }
    }

   </style>

    ```
