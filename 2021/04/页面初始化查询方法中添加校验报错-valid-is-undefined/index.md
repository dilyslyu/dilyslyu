# 页面初始化查询方法中添加校验，报错：'valid is undefined'

#### 问题描述：在表单提交的查询按钮上绑定了查询方法，初始化页面在 created 方法中也调用了该方法，要想在点击查询时对表单做验证，就要在查询方法中添加校验，初始化页面就报错：'valid is undefined'

#### 解决方法

重写一个方法，绑定在点击查询按钮上，在此方法中添加验证校验，并调用初始化查询方法（初始化查询方法在重置表单、分页查询时会被调用

```javascript
//点击查询按钮触发的事件（包含表单验证）
handleSearch(){
    let valid = this.refs["searchForm"].validate();
    if(!valid){
        return;
    }
    this.currentPage = 1;
    this.queryList();
},
//初始化查询方法
queryList(){
    const res = getQueryList({
        pageNo:this.currentPage,
        pageSize:this.pageSize,
        name:this.name
    });
    this.totalCount = res.totalRecord;
    this.formData  = res.data||null;
}

```

