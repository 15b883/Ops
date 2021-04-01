

```
# 查看默认密码
grep 'temporary password' /var/log/mysqld.log
# 修改root密码
ALTER USER 'root'@'localhost' IDENTIFIED BY '1q2w3e$R';

# 创建指定字符集数据库(库名 pipe，字符集使用 utf8mb4，排序规则 utf8mb4_general_ci)
CREATE database pipe DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
# 为用户授权
grant SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON eosdb.* TO 'eosuser'@'172.31.%' IDENTIFIED BY '1q2w3e$R';
grant SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, on computeplatform.* to root@'172.29.%';
GRANT ALL ON magento.* TO 'testuser'@'172.31.0.0/16';
#只读账户
GRANT SELECT ON testwalorder.* TO 'testwaluser02'@'%' IDENTIFIED BY '1q2wsd$%^3e$R';

FLUSH PRIVILEGES;

# 查看用户
select user,host from mysql.user;
# 查看自己的权限
show grants;
# 查看其他 MySQL 用户权限：
show grants for root@localhost;
# 查看支持字符集
show charset;
```

