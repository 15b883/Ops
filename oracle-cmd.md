

```sql
sqlplus / as sysdba  # 以管理员模式进入数据库
startup；            # 启动数据库
shutdown immediate；  # 停止数据库
startup nomount;      # nomount状态开启
select status from v$instance;  #查看数据库运行状态
show user   #查看当前登录用户
select name from v$datafile;  #查看数据文件存放位置
alter database open resetlogs； #打开resetlogs 
select member from v$logfile;  #查看red日志路径
```





