# vue 中添加用户


#### 实现流程

在确认按钮上绑定点击事件：`@click="addUser"`，在 methods 方法中定义 addUser 事件，预验证通过后发起网络请求，调用添加用户的 api ，最后关闭对话框，刷新列表。

#### 代码实现

```bash
addUser(){
    this.$refs.addFromRef.validate(async valid => {
        if (!valid) return 
        // 可以发起添加用户的网络请求
        const {data: res} = await this.$http.post(
            'users',this.addForm
        )

        if (res.meta.status !== 201){
            this.$message.error('添加用户失败！')
        }

        this.$message.success('添加用户成功！')
        //隐藏添加用户对话框
        this.addDialogVisible = false
        //重新获取用户列表数据
        this.getUserList()
    })
}

```

