# 深度作用选择器--样式穿透


### vue 深度作用选择器 `>>>` 与 `/deep/(sass/less)`

#### `/deep/` 后改为 `::v-deep`

#### 遇到的问题

vue 组件编译后，会将 template 中的每个元素加入 [data-v-xxxx] 属性来确保 style scoped 仅本组件的元素而不会污染全局，但如果你引用了第三方组件：
默认只会对组件的最外层（div）加入这个 [data-v-xxxx] 属性，但第二层开始就没有效果了。

1. 解决方法一
将 scoped 移除，或者新建一个没有 scoped 的 style（一个.vue文件允许多个style）
2. 解决方法二
深度作用选择器 `>>>`  或 `::v-deep`
 ">>>"只作用于css

```bash
.fuck >>> .weui-cells {
    // ...
}
```

sass/scss/less 使用 ::v-deep 

```bash
<style lang="scss" scoped>
.select {
  width: 100px;

  /deep/ .el-input__inner {
    border: 0;
    color: #000;
  }
}
</style>

```

#### 使用场景

vue 组件中，在 style 设置为 scoped 时候，对子组件是不生效的.这时可以使用 /deep/ 深度选择器。
一般使用场景有2个.

1. 是嵌套了子组件的父组件 `<style>` 上
2. 是UI组件的节点样式修改上,如swiper组件的轮播分页原点样式上.
需要注意的是:/deep/ 效果对其下所有子组件的样式都生效,不需在里面嵌套使用.不然还会不生效.

```bash
 /deep/ .swiper-pagination-bullet-active{
  background:#fff;
  .test{
      /*这里也生效哦*/
  }
}
```

#### 深度作用选择器总结

如果希望scope样式中的一个选择器作用的“更深”，例如影响子组件，可以使用 >>> 操作符，预处理器scss无法解析，使用::v-deep




