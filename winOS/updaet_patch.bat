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