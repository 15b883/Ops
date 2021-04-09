# 命令

使用组合键“Win+R”调用运行命令框，键入命令services.msc，回车，
或者，单击“开始”——>“搜索”中输入“服务”——>双击“服务”，回车；

## sc

```
sc query #查看所有服务
sc query |findstr EasyConnect #查找某个服务
```

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



## msiscsi

```
sc config msiscsi start= auto
net start msiscsi
#使用iscsicli命令连接Target
iscsicli QAddTargetPortal <Portal IP Address>
iscsicli ListTargets
iscsicli QloginTarget <target_iqn>！`
```



## 卸载应用
管理员身份运行WindowsPowerShell 输入下面命令即可
```
get-appxpackage #查看安装服务
Get-AppxPackage *WindowsStore* | Remove-AppxPackage     #应用商店
get-appxpackage *Microsoft.People* | remove-appxpackage  #人脉
get-appxpackage Microsoft.Wallet |remove-appxpackage
get-appxpackage Microsoft.WindowsCamera |remove-appxpackage
## XboxApp
Get-AppxPackage -allusers |findstr  Microsoft.XboxApp
Remove-AppPackage Microsoft.XboxApp_48.49.31001.0_x64__8wekyb3d8bbwe
```

## 查询安装命令路径
```
C:\> where aws    #默认
C:\> where /R c:\ aws  #指定盘符搜索
```
## 查看服务端口
```
netstat -ano |findstr 8080
```
## 查看服务是否启动
```
net start http
```
## 通过注册表查找安装的软件
通过此目录下可以删除一些无法删除干净的软件
如果某个软件绑定mac地址了，可以通过此地方进行删除
```
计算机\HKEY_LOCAL_MACHINE\SOFTWARE
```
# 常用链接

## Windows远程报错

CVE-2018-0886 的 CredSSP 更新
https://support.microsoft.com/zh-cn/help/4093492/credssp-updates-for-cve-2018-0886-march-13-2018

## windows 2008 R2 更新补丁
https://www.cnblogs.com/syavingcs/p/13225831.html

## 参考链接
https://docs.microsoft.com/zh-cn/previous-versions/windows/

## Windows10镜像 官方下载地址

https://www.microsoft.com/zh-cn/software-download/windows10ISO

https://msdn.itellyou.cn/

## Azure PowerShell 入门#

https://docs.microsoft.com/zh-cn/powershell/azure/get-started-azureps?view=azps-3.0.0

## 制作dos启动盘 

https://www.cnblogs.com/syavingcs/p/7968205.html