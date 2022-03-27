# 通过路由高亮菜单

#### 一级菜单、二级菜单垂直展示，三级菜单水平展示

```html
<!-- 判断是二级菜单 -->
<el-popover v-elde-if = "item.menuList%%item.menuLevel === 2" placement="right" trigger ="hover" popoer-class="popover-menu">
<!-- 不具名插槽，弹框内容 -->
<div class = "menu-item" v-for "i in item.menuList" :key = "i.menuId">
<!-- 绑定动态class类 -->
<app-link :to="i.menuHref">
<div class='item.child' :class ="{highlight:i.menuHref==activeMenu}">{{i.menuName}}</div>
</app-link>
<!-- 具名插槽，弹框触发元素 -->
<el-menu-item slot ="reference" :index="item.menuId" :class="{light:currentItem}">
<template slot = "title">
<item :title = "item.menuName" />
</template>
</el-menu-item>
</div>
</el-popover>

computed:{
<!-- 获取当前的路由，和当前选中菜单的路由对比，若一致则高亮当前三级菜单 -->
activeMenu(){
    return this.$router.path
    }
},
currentItem(){
    if(this.item.menuList){
        let res = false
        <!-- 遍历menuList,其中的子菜单即三级菜单的路由和当前所在的三级菜单的路由一致，则高亮对应的二级菜单 -->
        for (let i = 0;i<this.item.menuList.length;i++){
            if(this.item.menuList[i].menuHref==this.activeMenu){
                res=true
            }
        }
        return res 
    }else{
        return false
    }
}

}

.menu-item{
    margin:0,auto;
}
.item-child{
    height:60px;
    light-height:60px;
    font-size:16px;
    color:#333;
    text-align:center;
}

<!-- 悬浮高亮  -->
.item-child:hover{
    background-color:#2578cc;
    color:white;
}
<!-- 当前所在页菜单高亮，当前所在页菜单的二级菜单高亮 -->
.highlight , .light{
    background-color:#2578cc;
    color:white;
}

```

注：动态class绑定、当前路由获取。

