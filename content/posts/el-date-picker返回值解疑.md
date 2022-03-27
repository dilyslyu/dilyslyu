---
title: el-date-picker返回值解疑
date: 2021-04-15 09:15:55
tags:
---
#### 一、组件说明

`DatePicker` 日期选择器，默认接收并返回 `Date` 对象。使用 `format` 指定输入框的格式；使用 `value-format` 指定绑定值的格式。

#### 二、问题及解决方法

问题：
使用了`el-date-picker`, type 属性指定为 year ，输入框格式为“XXXX” ，选中`2026` ，控制台打印出 `2026-01-01:00:00`,network 请求参数中 time=2025-12-31T16:00:00
解决方法：
在`el-date-picker`中添加属性 ` value-format = "yyyy" ` 即可。
