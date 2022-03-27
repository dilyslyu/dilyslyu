# element `el-select`中的远程搜索+自定义展示选项列表+输入框只展示某个选项中的一部分


```HTML
<template>
  <el-select
    v-model="value"
    filterable
    remote
    reserve-keyword
    placeholder="请输入学号\姓名"
    :remote-method="remoteMethod"
    :loading="loading">
    <el-option
      v-for="item in names"
      :key="item.code"
      :label="item.code"
      :value="item.name">
      <!-- 自定义下拉选项模版，此处选项模版中 左侧展示name，右侧展示code，输入框绑定的value是el-option中的label-->
      <span style = "float:left">{{item.name}}</span>
      <span style = "float:right,color: #8492a6; font-size: 13px">{{item.code}}</span>
    </el-option>
  </el-select>
</template>

```

```JavaScript
data() {
      return {
        names: [],//el-option for中的数据
        value: "",//选择框绑定的数值，若多选时定义为一个数组
        topicList: [],//用于接收请求到的数据
        loading: false,
      }
    },
    methods: {
      //远程搜索方法，绑定在el-select属性中
    async remoteMethod(query) {
        if (query !== '') {
          this.loading = true;
          let self = this;
          var topicList = await getStudentInfo();
          topicList.forEach(item = > {
            //使用forEach对数组遍历；在请求到的数组中每一项添加一个属性value，后面作为筛选匹配条件
            item.value =item.name+item.code;
          })
          //console.log(topicList);
          self.topicList=topicList//关注作用域
          setTimeout(() => {
            this.loading = false;
            this.names = this.topicList.filter(item => {
              //console.log(item.value) 此处的value即为前面添加的属性value
              return item.value.toLowerCase()
                .indexOf(query.toLowerCase()) > -1;//检测输入的字符串是否包含在item.value中
            });
          }, 200);
        } else {
          //如果输入框没有输入内容，则没有选项提示
          this.names = [];
        }
      }
    }

    ```

