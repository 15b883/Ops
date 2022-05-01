#!/bin/bash
# check os status
# OS:CentOS-7
# SYAVINGCSX
# yum install iftop iotop htop
# usage: sh check_status.sh > checkstatus_`date +'%Y-%m-%d'`.log
#

# 查看历史命令
# 

## shell scripts
Hostname(){
    # 主机名
    echo -e "\033[31m ----------主机名---------- \033[0m"
    hostname -s
}

HostIP(){
    # 主机主IP和附加的多个IP
    echo -e "\033[31m ----------主机IP----------\033[0m"
    hostname -i
    hostname -I
}

Login_user() {
    # 登录用户
    echo -e "\033[31m ----------显示登录用户----------\033[0m"
    w
}

os_Version() {
    # 系统版本
    echo -e "\033[31m ----------系统版本----------\033[0m"
    cat /etc/redhat-release 
}

services_Port() {
    # 本地所运行服务
    echo -e "\033[31m ----------本机服务----------\033[0m"
    netstat -ntpl
}

host_free() {
    # 查看内存使用率
    echo -e "\033[31m ----------本机内存使用率----------\033[0m"
    free -h
}

host_disk() {
    # 查看磁盘使用率
    echo -e "\033[31m ----------本机磁盘使用率----------\033[0m"
    df -TH
}

log_msg() {
    # 查看系统日志最后20条
    echo -e "\033[31m ----------查看系统日志----------\033[0m"
    tail -20 /var/log/messages
}

log_secure() {
    # 查看系统安全日志最后20条
    echo -e "\033[31m ----------查看安全日志----------\033[0m"
    ail -20 /var/log/secure
}

history_info() {
    # 查看最近执行的历史记录
    echo -e "\033[31m ----------查看最近执行的历史记录----------\033[0m"
    history

}


##
Hostname()
HostIP()
Login_user()
os_Version()
services_Port()
host_free()
host_disk()
log_msg()
log_secure()
history_info()