# vsftp



## 下载链接

https://security.appspot.com/downloads/vsftpd-3.0.3.tar.gz

https://blog.csdn.net/lixinfu1980/article/details/80414257?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase

## 停止服务

```
service vsftpd stop 
service iptables stop 
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config; 
```

## 查看版本

```
vsftpd -v 
```

