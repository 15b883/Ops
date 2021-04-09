#!/bin/bash
#
#

install_package() {
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.back
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo &> /dev/null
    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo &> /dev/null
    echo -e "\033[31m正在安装常用软件包\033[0m"
    yum -y install vim lsof zip nmap nc telnet wget git strace openssl openssl-devel gcc gcc-c++ cmake bind-utils libxml2-devel net-tools sysstat &> /dev/null
    yum -y install ntpdate curl telnet lbzip2 bzip2 bzip2-devel pcre pcre-devel zlib-devel python-devel lrzsz man glibc glibc-devel &> /dev/null   
}

mkdir_directory() {
   ## 创建目录
   ## 第三方安装包都放到/usr/local/file
   ## echo "export PATH=/usr/local/file/bin:$PATH" >> /etc/profile
   ## source /etc/profile
   ## groupadd -r nginx && useradd -s /sbin/nologin -g nginx -r nginx ##服务使用账户
   [ ! -d /opt/package ] && mkdir -p /opt/package
   [ ! -d /.root/scripts ] && mkdir -p /.root/scripts
   ssh-keygen -t rsa -b 4096 -P '' -f ~/.ssh/id_rsa > /dev/null 2>&1
   ## ssh-copy-id -i .ssh/id_dsa.pub root@172.16.1.41
   ## touch ~/.ssh/authorized_keys
}

set_ssh() {
#备份sshd配置文件
cp /etc/ssh/sshd_config{,.bak}  
## 授权root登陆
sed -e 's/\#PermitRootLogin yes/PermitRootLogin yes/' -i /etc/ssh/sshd_config > /dev/null 2>&1
## 禁止空密码登陆
sed -e 's/\#PermitEmptyPasswords no/PermitEmptyPasswords no/' -i /etc/ssh/sshd_config > /dev/null 2>&1
## 禁止使用密码登陆
sed -e 's/\#PasswordAuthentication no/PermitEmptyPasswords yes/' -i /etc/ssh/sshd_config > /dev/null 2>&1

#sed -e 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/' -i /etc/ssh/sshd_config > /dev/null 2>&1
sed -e 's/#UseDNS yes/UseDNS no/' -i /etc/ssh/sshd_config > /dev/null 2>&1
#修改ssh默认连接端口
#sed -e 's/#Port 22/Port 22222/' -i /etc/ssh/sshd_config > /dev/null 2>&1
sed -e 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/' -i /etc/ssh/sshd_config > /dev/null 2>&1
#sed -i '/StrictHostKeyChecking/ s/ask/no/'  /etc/ssh/ssh_config  > /dev/null 2>&1
#sed -i '/StrictHostKeyChecking/ s/^#/^/'  /etc/ssh/ssh_config  > /dev/null 2>&1
#sed -i '/StrictHostKeyChecking/a UserKnownHostsFile \/dev\/null' /etc/ssh/ssh_config > /dev/null 2>&1
#sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/' /etc/ssh/ssh_config  > /dev/null 2>&1
#重启ssh服务
systemctl restart sshd > /dev/null 2>&1
}

time_sync() {
   #时区修改与时间同步
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
   # /usr/sbin/ntpdate ntp1.aliyun.com;/sbin/hwclock -w"
   # echo "00 * * * *   /usr/sbin/ntpdate ntp1.aliyun.com;/sbin/hwclock -w" >>/var/spool/cron/root
   # chmod 600 /var/spool/cron/root
   echo "00 01 * * *   /usr/sbin/ntpdate time.nist.gov >/dev/null 2>&1" >> /var/spool/cron/root
   [ `grep ntpdate /var/spool/cron/root |wc -l` -ne 0 ] && action "uptime set" /bin/true || action "uptime set" /bin/false
}

closed_service() {
    #关闭selinux
    sed -i 's#=enforcing#=disabled#g'  /etc/selinux/config
    setenforce 0
    getenforce

    disable_services=(firewalld postfix acpid ip6tables mcelogd mdmonitor rpcbind rpcgssd rpcidmapd auditd haldaemon lldpad atd kdump netfs nfslock openct)
    for service in ${disable_services[@]};do
        systemctl disable ${service} &> /dev/null
    done
    systemctl enable sshd crond &> /dev/null
}

set_limits() {
cat >> /etc/security/limits.conf <<EOF
* soft nproc 65530
* hard nproc 65530
* soft nofile 65530
* hard nofile 65530
EOF

}

set_utf8() {
    ## 更改字符集
    ## 查看支持字符集 locale -a
    /bin/cp /etc/sysconfig/i18n /etc/sysconfig/i18n.bak
    echo 'LANG="en_US.UTF-8"' >/etc/sysconfig/i18n
}

time_out() {
    ##时间超时 历史纪录
    echo 'export TMOUT=600' >> /etc/rc.local 
    echo 'export HISTSIZE=50' >> /etc/rc.local 
    echo 'export HISTFILESIZE=50' >> /etc/rc.local
}

lock_file() {
    #锁定关键系统文件
    chattr +ai /etc/passwd
    chattr +ai /etc/shadow
    chattr +ai /etc/group
    chattr +ai /etc/gshadow
    chattr +ai /etc/inittab
}

clean_issue() {
    #清空/etc/issue，去除系统及内核版本登陆前的屏幕显示
   /bin/cp /etc/issue /etc/issue.bak
   >/etc/issue
   [ `cat /etc/issue|wc -l` -eq 0 ] && action "/etc/issue set" /bin/true || action "/etc/issue set" /bin/false
}

optimize_kernel() {
cat >>/etc/sysctl.conf<<EOF
#禁止ping
net.ipv4.icmp_echo_ignore_all=1
#表示开启SYN Cookies。当出现SYN等待队列溢出时，启用cookies来处理，可防范少量SYN攻击，默认为0，表示关闭；
net.ipv4.tcp_syncookies = 1     
#表示开启重用。允许将TIME-WAIT sockets重新用于新的TCP连接，默认为0，表示关闭；
net.ipv4.tcp_tw_reuse = 1       
#表示开启TCP连接中TIME-WAIT sockets的快速回收，默认为0，表示关闭； 
net.ipv4.tcp_tw_recycle = 1     
#修改系統默认的 TIMEOUT 时间
net.ipv4.tcp_fin_timeout=2        
#表示当keepalive起用的时候，TCP发送keepalive消息的频度。缺省是2小时，改为20分钟。
net.ipv4.tcp_keepalive_time = 1200         
#表示用于向外连接的端口范围。缺省情况下很小：32768到61000，改为10000到65000。（注意：这里不要将最低值设的太低，否则可能会占用掉正常的端口！） 
net.ipv4.ip_local_port_range = 10000 65000 
#表示SYN队列的长度，默认为1024，加大队列长度为8192，可以容纳更多等待连接的网络连接数。 
net.ipv4.tcp_max_syn_backlog = 16384       
#表示系统同时保持TIME_WAIT的最大数量，如果超过这个数字，TIME_WAIT将立刻被清除并打印警告信息。默认为180000，改为5000。对于Apache、Nginx等服务器，上几行的参数可以很好地减少TIME_WAIT套接字数量，但是对于 Squid，效果却不大。此项参数可以控制TIME_WAIT的最大数量，避免Squid服务器被大量的TIME_WAIT拖死。 
net.ipv4.tcp_max_tw_buckets = 5000  
 
net.ipv4.route.gc_timeout=100
net.ipv4.tcp_syn_retries=1
net.ipv4.tcp_synack_retries=1
net.core.somaxconn=16384
net.core.netdev_max_backlog=16384
net.ipv4.tcp_max_orphans=16384
net.nf conntrack max=25000000
net.netfilter.nf_conntrack_max=25000000
net.netfilter.nf_conntrack_tcp_timeout_established=180
net.netfilter.nf_conntrack_tcp_timeout_time_wait=120
net.netfilter.nf_conntrack_tcp_timeout_close_wait=60
net.netfilter.nf_conntrack_tcp_timeout_fin_wait=120
net.nf_conntrack_max = 25000000
net.netfilter.nf_conntrack_max = 25000000
net.netfilter.nf_conntrack_tcp_timeout_established = 180
net.netfilter.nf_conntrack_tcp_timeout_time_wait = 120
net.netfilter.nf_conntrack_tcp_timeout_close_wait = 60
net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 120      
EOF
}

############
install_package()
# mkdir_directory()
set_ssh()
time_sync()
closed_service()
set_limits() 
set_utf8() 
# time_out()
# lock_file()
clean_issue() 
optimize_kernel()