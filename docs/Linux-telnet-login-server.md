## 下载telnet

可以挂载本地ISO，或者到网上下载相关的rpm包

```
[root@testenv ~]# rpm -qa telnet-server
[root@testenv ~]# yum install telnet-server xinetd -y


[root@testenv xinetd.d]# ls
chargen-dgram  chargen-stream  daytime-dgram  daytime-stream  discard-dgram  discard-stream  echo-dgram  echo-stream  tcpmux-server  telnet  time-dgram  time-stream
You have mail in /var/spool/mail/root
[root@testenv xinetd.d]# pwd
/etc/xinetd.d
[root@testenv xinetd.d]# cat telnet  ##此配置文件如果没有的话，可以复制下面的
# default: on

# description: The telnet server serves telnet sessions; it uses \

# unencrypted username/password pairs for authentication.
service telnet
{
flags = REUSE
socket_type = stream
wait = no
user = root
server = /usr/sbin/in.telnetd
log_on_failure += USERID
#disable = yes
}
```

## 重启服务

```
[root@testenv xinetd.d]#systemctl restart xinetd
[root@testenv xinetd.d]# netstat -ntpl
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      1267/master
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      1009/sshd
tcp6       0      0 ::1:25                  :::*                    LISTEN      1267/master
tcp6       0      0 :::22                   :::*                    LISTEN      1009/sshd
tcp6       0      0 :::23                   :::*                    LISTEN      1749/xinetd
```

## 切换到root

通过其他用户telnet登录在切换到root

```
➜  ~ telnet 172.16.10.50
Trying 172.16.10.50...
Connected to 172.16.10.50.
Escape character is '^]'.
Password:
Login incorrect

testenv login: test
Password:
[test@testenv ~]$
[test@testenv ~]$
[test@testenv ~]$ ls
[test@testenv ~]$ sudo -i

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for test:
Sorry, try again.
[sudo] password for test:
test is not in the sudoers file.  This incident will be reported.
[test@testenv ~]$
[test@testenv ~]$ su - root  ##输入root的密码 不是test用户的密码
Password:
Last login: Fri Aug 14 07:03:39 EDT 2020 from 172.16.10.1 on pts/0
Last failed login: Fri Aug 14 07:43:31 EDT 2020 on pts/1
There were 7 failed login attempts since the last successful login.
[root@testenv ~]#
[root@testenv ~]# pwd
/root
[root@testenv ~]#
```

## 允许root用户通过telnet登陆
编辑/etc/pam.d/login，注释掉下面这行

```
cp /etc/pam.d/login /etc/pam.d/login.bak
vi /etc/pam.d/login
#auth [user_unknown=ignore success=ok ignore=ignore default=bad] pam_securetty.so
```

## 配置/etc/securetty
先备份/etc/securetty文件：

```
cp /etc/securetty /etc/securetty.bak
```

添加超级用户登陆设备。
添加超级用户登陆设备至/etc/securetty文件：

```
vi /etc/securetty
echo "pts/1" >> /etc/securetty
echo "pts/2" >> /etc/securetty
echo "pts/3" >> /etc/securetty
echo "pts/4" >> /etc/securetty
echo "pts/5" >> /etc/securetty
echo "pts/6" >> /etc/securetty
echo "pts/7" >> /etc/securetty
echo "pts/8" >> /etc/securetty
echo "pts/9" >> /etc/securetty
echo "pts/10" >> /etc/securetty
echo "pts/11" >> /etc/securetty
```

## 开启root用户远程登陆
编辑/etc/pam.d/remote，注释下列这行：

```
cp /etc/pam.d/remote /etc/pam.d/remote.bak
vi /etc/pam.d/remote
#auth required pam_securetty.so
```

重启xinetd服务

```
systemctl restart xinetd
```

