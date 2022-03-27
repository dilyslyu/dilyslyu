---
title: 怎么让一个 div 水平垂直居中
date: 2022-03-08 15:34:10
tags:
---

```html
<div class = "parent">
    <div class= child></div>
</div>

```

```css
div.parent{
    display:flex;
    justify-content:center;
    align-items:center;
}

div.parent{
    position:relative;
}
div.child{
    position:absolute;
    top:50%;
    left:50%;
    transform:translate(-50%,-50%);
}
/*或者*/
div.child{
    width:50px;
    height:10px;
    position:absolute;
    top:50%;
    left:50%;
    margin-left:-25px;
    margin-top:-5px;
}
/*或者*/
div.child{
    width:50px;
    height:10px;
    position:absolute;
    top:0;
    left:0;
    right:0;
    bottom:0;
    margin:auto;
}

```
