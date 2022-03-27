# 解决 [Element Warn][Form]model is required for validate to work

### 可能出现这种错误的两种情况

    1. 属性绑定错误

确保使用:model，而不是v-model

    ```html
    <el-form :model="form" ref="form" :rules="rules" label-position="left" label-width="120px">
    </el-form>
    ```

    2. ref重复

检查是否在其他el-form中使用了相同的ref名，多个el-form组件ref命名要独立
