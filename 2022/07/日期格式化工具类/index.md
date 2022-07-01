# 日期格式化工具类

### moment.js 的常用方法

vue项目中，需要把 moment.js 挂载到全局上（即vue 的原型链上），访问时直接使用 this.moment();
vue项目中不挂载到全局，单文件（单组件）使用：

```javascript
  import moment from 'moment';
  moment()
```

1. 初始化日期/时间
初始化日期： moment().format('YYYY-MM-DD');
初始化日期时间： moment().format('YYYY-MM-DD HH:mm:ss');
2. 格式化日期/时间
格式化日期： moment(value).format('YYYY-MM-DD');
格式化日期时间： moment(value).format('YYYY-MM-DD HH:mm:ss');
3. 加/减法 操作之前必须使用 this.moment()(日期变量)；将要操的日期转为 moment.js 可以处理的日期时间格式
加法： this.moment().add(1,'months').format('YYYY-MM-DD'); ==> 当前日期加一个月并输出格式为 'YYYY-MM-DD'
加法： this.moment(startDate).add(2,'days').format('YYYY-MM-DD'); ==> 指定日期（startDate）加两天并输出格式为 'YYYY-MM-DD'
减法： this.moment().subtract(7,'days'); ==>当前时间减去7天
减法： this.moment(startDate).subtract(2,'days').format('YYYY-MM-DD'); ==> 指定日期（startDate）减去两天并输出格式为 'YYYY-MM-DD'
4. 获取星期几
this.moment().day()或 this.moment(startDate).day() ==>当前日期/指定日期是星期几
5. 获取时间差（以毫秒计算）
两个日期/时间的时差：this.moment(endTime).diff(this.moment(startTime),'days') ==>开始时间和结束时间的时间差，以‘天’为单位；endTime 和startTime 都是毫秒数；
注意：计算时间差时，可以以“years”、"days"、"hours"、"minutes"以及"seconds"为单位输出！
6. 使用示例

```javascript
// 页面初始化时调用此方法，实时展示时间
getNowTime(){
  this.nowDate = moment().format('YYYY/MM/DD HH:mm:ss')
  setTimeout(()=>{
    this.getNowTime()
  },1000)
}
```

### Day.js 的使用

1. 简介
  与 moment.js 一样，day.js 是一个轻量的处理时间和日期的 javascript 库，两者的 API 设计保持完全一样，只要会 moment.js ，就会 day.js
  特点：
  和moment.js 相同的 API 和用法；
  不可变数据；
  支持链式操作；
  仅2kb大小的微型库；
  全浏览器兼容。
2. 使用方式
  安装： ·npm install dayjs·

    ```javascript
      var dayjs =require('dayjs')
      dayjs().format()
      // 或
      import dayjs from 'dayjs'
    ```

3. 常用方法
获取当前时间戳：dayjs('2022-06-03 11:00:00').unix()
格式化时间：

    ```javascript
      let time = 1627747199 
      const dateFormat = dayjs(time).format('YYYY-MM-DD HH:mm:ss')
      console.log(dateFormat)// 2021-07-31 23:59:59

    ```

指定日期：获取上一个月15号 00:00:00 时间戳

  ```javascript
      dayjs()
      .subtract(1,'months')
      .date(15)
      .hour(0)
      .minute(0)
      .second(0)
      .unix()

  ```

  等同于

  ```javascript
      dayjs()
      .subtract(1,'months')
      .date(15)
      .starOf('day')
      .unix()

  ```

