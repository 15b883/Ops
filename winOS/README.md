## 查看本机补丁信息

cmd 执行下面命令
```
systeminfo
```
![](https://img2020.cnblogs.com/blog/1043682/202007/1043682-20200702170009942-1090380354.png)

或者

![](https://img2020.cnblogs.com/blog/1043682/202007/1043682-20200702170024522-1761915597.png)


## 执行更新脚本

```
REM @echo off
rem author: 15b883
rem function: update_bug
rem release date: 2020.07.02
 
@echo off
cd bug_packages 
rem 开始安装
echo 开始安装 Windows xxx 高危漏洞补丁包
echo 请稍等...
wusa.exe .\windows6.1-kb4499164-x64_21696444837b433df698a5bc73b0cc23df17bd58.msu /quiet /norestart
echo Windows xxx 高危漏洞补丁包安装完成.
```
/quiet 以安静模式运行该工具，当它运行无需用户交互。
/norestart 防止 Wusa.exe 重新启动计算机。

## 脚本与补丁包目录分布

![](https://img2020.cnblogs.com/blog/1043682/202007/1043682-20200702170127537-680030810.png)

## 执行脚本

![](https://img2020.cnblogs.com/blog/1043682/202007/1043682-20200702170203932-601451498.png)

## 确认补丁安装

![](https://img2020.cnblogs.com/blog/1043682/202007/1043682-20200702170629706-1674038328.png)
![](https://img2020.cnblogs.com/blog/1043682/202007/1043682-20200702170646476-31078234.png)


## 参考资料
https://blog.csdn.net/qq_33468857/article/details/89576242?utm_medium=distribute.pc_relevant_download.none-task-blog-BlogCommendFromBaidu-17.nonecase&depth_1-utm_source=distribute.pc_relevant_download.none-task-blog-BlogCommendFromBaidu-17.nonecas
https://support.microsoft.com/zh-cn/help/934307/description-of-the-windows-update-standalone-installer-in-windows