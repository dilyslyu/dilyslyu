# elementUI中对话框意外关闭问题

#### 问题分析

`el-dialog`的`closeOnclickModal`绑定的是`click`事件，当在弹框内`mousedown`，拖拽到弹窗外`mouseup`时，也会触发`click`事件，导致弹窗被意外关闭。因此在全局通用常量`src/utils/global.js`中覆盖`dialog`组件，把`closeOnclickModal`的默认值设置为`false`

#### 解决实例p[]

```javascript
import globalConst from 'src/config/globals.js' //引入全局常量
// src/config/globals.js 全局常量文件引入到`src/utils/global.js`，`src/utils/global.js`再引入到`main.js`
// export default {
//     'PAGE_SIZE':20,
//     'EMPTY_TXT':'暂无数据',//在vue文件中使用，:empty-text='$_g.EMPTY_TXT', :page-size='$_g.PAGE_SIZE',在`data`里面`pageSize:this.$_g.PAGE_SIZE`
//     'PAGESIGES':[10,20,30],
//     'APPID':'hdjx73649247'
// }
import {Dialog} from 'element-ui'
import Vue from 'vue'

// 此处可引入全局filters

//全局混入
export default {
    install: function(Vue){
        Vue.prototype.$_g =globalConst
        Vue.component('el-dialog',{
            extends:Dialog,
            props:{
                ...this.props,
                closeOnClickModal:{
                    type:Boolean,
                    default:false
                }
            }
        })
    }
}

```

