# 校验方法-自定义校验方法

### 校验方法-自定义校验方法

```HTML
data(){
    var validateYear = (rule,value,callback)=>{
        if(!this.ruleForm.dateValue){
            callback(new Error('请选择年度范围'))
        }else if(this.ruleForm.dateValue){
            this.$refs.ruleForm.validateField('dateValue')
        }
        callback()
    }
    return {
        rules:{
            code:[
                {validator:ValidateYear,trigger:'blur'}//触发输入框 code 接口全量查询时，校验上一个查询条件 dateValue 是否存在以及日期范围是否正确
            ]
        }
    }
}
```

### 问题描述

#### 查询条件中搜索输入框需要点击触发全量查询下拉列表项，接口传参取自上一个日期查询条件，查询条件是日期范围组件，需要控制在同一年，因此在点击输入框触发查询时需要先校验日期是否存在以及日期范围合理性

```javascript
//清空输入框，触发全量查询
// async codeFocus(){
//     this.codeOptions=[]
//     if(!this.ruleForm.dateValue||this.ruleForm.dateValue[0]!==this.ruleForm.dateValue[1]){
//         const valid =await rhis.$refs['ruleForm'].validate()
//         if(!valid){
//             return
//         }
//     }
//     await this.remoteMethod()
// },
//选择日期范围改变，清空 code 输入框
// handleChange(){
//     this.ruleForm.code=''
// }

//查询按钮，从第一页开始
// async handleSearch(){
//     const valid =await rhis.$refs['ruleForm'].validate()
//     if(!valid){
//         return
//     }
//     this.currentPage=1
//     this.queryList()
// }
```

