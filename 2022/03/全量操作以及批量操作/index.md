# 全量操作以及批量操作


```html
<el-button type="primary" class="lock" @click="lockAll">
    全部锁
</el-button>
<el-button type="text" class="btn"  icon="el-icon-lock" @click="batchAll">
    批量锁
</el-button>
```

```javascript
async lockAll(){//全部
    try{
        await lockAllApi({lock:1})
        this.$message.success('suoding chenggong')
        await this.refreshList()
    }catch(e){
        console.warn(e)
    }
}

handleSelectionchange(val){ // 表格多选
    this.multipleSelection = val
}

async lockAll(){ // 批量
    try{
        if(this.multipleSelection.length ===0){
            this.$message.warning('请至少选择一项') //判断表格没有选中时，给出提示不调接口  
            return false
        }
        await this.$confirm('是否确认锁？'，‘提示’)
        const arr = []
        for(const item of this.multipleSelection){
            arr.push(item.code)
        }
        await lockApi({
            lock: 1,
            code: arr.join(',')})
        this.$message.success('suoding chenggong')
        await this.refreshList() // 操作之后刷新列表信息
    }catch(e){
        console.warn(e)
    }
}

```

