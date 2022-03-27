# 表单校验rules

```javascript
import valid from '@/utils/validator'

formrules:{
    code:[
        {min: 0 ,max: 20,message:'长度1到20',trigger:['blur','change']},//非必输的最小值为0，不能为1
        {validator: valid.isNumber,message:'只允许输入数字'，trigger:['blur','change']}
    ]，
    name:[
        {required:true,message:'请输入名字',trigger:['blur','change']},
        {min: 1 ,max: 20,message:'长度1到20',trigger:['blur','change']},//触发方式加上change,随时校验输入
        {validator: valid.isNumber,message:'只允许输入数字'，trigger:['blur','change']}
    ]
}
```

`validator.js`

```javascript
export default {
    'isNumber':(rule,value,callback)=>{
        if (value===''){
            callback()
            return
        }
        let pass = /^[0-9]*$/g.test(value)
        if(!pass){
            callback(new Error (rule.message ||'必须为整数'))
        }
        callback()
    }
}
```

