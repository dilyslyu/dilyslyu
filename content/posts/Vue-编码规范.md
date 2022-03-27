---
title: Vue 编码规范
date: 2021-04-07 10:55:03
tags:
---
#### 一、规避错误、增强可读性、确保一致性

1. 组件名为多个单词
2. 单文件组件的文件名首写字母大写开头
3. 和父组件紧密耦合的子组件应该以父组件名为前缀
4. 单例组件名以The前缀命名，以示其唯一性
5. 组件名以高级别的单词开头，以描述性的修饰词结尾
6. 组件名应该倾向于完整的单词，而不是缩写
7. 在单文件组件、字符串模版和JSX中组件名应该是PascalCase，在DOM模版中是 kebab-case
8. 基础组件以特定的前缀开头： Base、App、V
9. 尽量避免使用多级目录，编辑器在多级目录中查找要比在单个components目录中滚动查找花费更多精力
10. 组件的 data 必须是一个返回对象的函数
11. prop 定义至少指定其类型，在声明prop时应为camelCase
12. 为 for 设置键值 key
13. 不要把 `v-if` 和 `v-for` 同时用在同一元素上，`v-for` 比 `v-if`具有更高的优先级：`v-if` 用计算属性代替或将其移至容器元素上
14. 为单文件组件样式设置作用域，CSS Modules优先、scoped attribute 次之，且都要使用唯一的 class 类名，尽量避免使用元素选择器
15. 私有的property名使用 $_ 前缀
16. 在单文件组件、字符串模版、JSX中使用自闭合标签，在DOM模版中使用额外的闭合标签
17. 多个attribute元素应该分多行撰写，每个 attribute 一行
18. 组件模版应该只包含简单的表达式，复杂的表达式重构为计算属性或算法
19. 把复杂的计算属性尽可能分为多个更简单的property，在多个 property 之间增加一个空行
20. 非空 HTML attribute的值应该始终带引号
21. 统一使用指令缩写
22. 组件/实例的选项统一顺序：name-components-data-computed-watch-created-mounted-methods
23. 元素/组件的多个attribute应该有统一：`is _ v-for _ v-if _ v-once _  ref/key  _ v-model  v-on  _  v-html`

#### 二、谨慎使用潜在危险的模式

1. 如果一组 `v-if` + `v-else` 的元素类型相同，最好使用key
2. 应优先通过prop和事件进行父子组件之间的通讯，而不是`this.$parent`或变更`prop`
3. 应优先通过Vuex管理全局状态，而不是通过`this.$root`或一个全局事件总线