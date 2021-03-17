# Windows命令行

## 查询安装命令路径

```powershell
C:\> where aws    #默认
C:\> where /R c:\ aws  #指定盘符搜索
```

## 查看服务端口

```powershell
netstat -ano |findstr 8080
```

## 查看服务是否启动

```powershell
net start http
```

## 查看系统信息

```powershell
systeminfo
```


