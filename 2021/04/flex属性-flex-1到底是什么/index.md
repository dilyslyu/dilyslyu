# flex属性-flex:1到底是什么

#### 问题解答

flex：1即为flex-grow：1，经常用作自适应布局，将父容器的display：flex，侧边栏大小固定后，将内容区flex：1，内容区则会自动放大占满剩余空间。

```html
<p class="p-flex"> 
    <span>1 content 1</span>
    <span class="content-2">2 content 22</span>
    <span>3 content 333</span>
</p>

<style rel="stylesheet/scss" lang="scss">
.p-flex{
  display: flex;
}
.content-2{
  flex: 1;
  text-align: center;
}
</style>

```

#### flex 属性详解

flex属性 是 `flex-grow`、`flex-shrink`、`flex-basis`三个属性的缩写。

推荐使用此简写属性，而不是单独写这三个属性。

`flex-grow`：定义项目的的放大比例；
    默认为0，即 即使存在剩余空间，也不会放大；
    所有项目的flex-grow为1：等分剩余空间（自动放大占位）；
    flex-grow为n的项目，占据的空间（放大的比例）是flex-grow为1的n倍。

`flex-shrink`：定义项目的缩小比例；
    默认为1，即 如果空间不足，该项目将缩小；
    所有项目的`flex-shrink`为1：当空间不足时，缩小的比例相同；
    `flex-shrink`为0：空间不足时，该项目不会缩小；
    `flex-shrink`为n的项目，空间不足时缩小的比例是`flex-shrink`为1的n倍。

`flex-basis`： 定义在分配多余空间之前，项目占据的主轴空间（main size），浏览器根据此属性计算主轴是否有多余空间，
    默认值为auto，即 项目原本大小；
    设置后项目将占据固定空间
    所以flex属性的默认值为：0 1 auto （不放大会缩小）
    ```html
    flex为none：0 0 auto  （不放大也不缩小）
    flex为auto：1 1 auto  （放大且缩小）
    flex为一个非负数字n：该数字为flex-grow的值，
    flex：n；=  flex-grow：n；
    flex-shrink：1；
    flex-basis：0%；
    flex为两个非负数字n1，n2： 分别为flex-grow和flex-shrink的值，
    flex：n1 n2; = flex-grow：n1；
    flex-shrink：n2；
    flex-basis：0%；

   flex为一个长度或百分比L：视为flex-basis的值，

   flex: L; =  flex-grow：1；
    shrink：1；
    flex-basis：L；

   flex为一个非负数字n和一个长度或百分比L：分别为flex-grow和flex-basis的值，

   flex：n L；= flex-grow：n；
    flex-shrink：1；
    flex-basis：L;
    ```
   可以发现，flex-grow和flex-shrink在flex属性中不规定值则为1，flex-basis为0%。
