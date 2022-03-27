---
title: Oracel 批量插入数据
date: 2021-12-22 17:08:57
tags:
---
### 代码示例 （在excel中插入批量单元格数据：C6~C50）

```sql
declare
i int;
begin
i := 5;
while (i< 49) 
loop
i := i+1
insert into REPORT_RESULT (AUTO_INC,YEAR,KIND,CODE,EXCEL_NO,REMARK,MODYFY_TIME)
select SEQ_REPORT_RESULT.NEXTVAL,2021,01,120,'文本','C' || i, sysdate from dual;
end loop;
commit;
end;
```
