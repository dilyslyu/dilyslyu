# 根据不同日期置灰按钮


```javascript
//根据选择的不同日期，控制切换按钮是否置灰
<el-date-picker
    v-model="selectForm.validDate"
    type="month"
    value-format="yyyyMM"
    placeholder="选择月"
    clearable
    @change=changeConfirmDisabled>
</el-date-picker>

<el-button type ="primary" :disabled="is_confirm">确认</el-button>

const month = ["12","01","02","03","04","05","06","07","08","09","10","11"]
export default{
data(){
    return {
        is_confirm:false
    }
}
methods:{
changeConfirmDisabled(){
    if(this.selectForm.validDate === (new Date().getUTCFullYear().toString()+month[new Date().getMonth()])){
        this.is_confirm=false
        console.log (this.is_confirm)
    }else{
        this.is_confirm=true
        console.log("zhuhui",this.is_confirm)
    }
}
}

}
```

