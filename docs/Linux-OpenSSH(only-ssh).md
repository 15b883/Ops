## 下载地址

http://www.openssh.com/portable.html

 https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/

##  检查

```shell
# 记录下面信息，在更新后进行检查
# 主机名
hostname -I
# 系统版本
cat /etc/redhat-release
# SSH版本
ssh -V
# openssl 安装目录
openssl version -a
# 检查依赖包是否已安装 
rpm -qa | grep -E  "zlib-devel|openssl-devel|gcc"

if [ `rpm -qa|grep -c gcc` -eq 1 ]; then echo "yes" ; else echo "no"; fi

```

## 备份 

备份SSH配置文件方便还原

```shell
mkdir /etc/ssh.bak
mv /etc/ssh/ /etc/ssh.bak/
```

## 更新SSH

```
tar xf openssh-8.5p1.tar.gz  
cd openssh-8.5p1
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-ssl-dir=/usr/local/openssl --with-md5-passwords 

make && make install
```

--prefix 安装目录 # 此目录需要确认之前安装SSH的目录有时候不是usr目录下
--sysconfdir 配置文件目录
--with-ssl-dir 指定 OpenSSL 的安装目录
--with-privsep-path 非特权用户的chroot目录
--with-privsep-user=sshd 指定非特权用户为sshd
--with-zlib 指定zlib库的安装目录
--with-md5-passwords 支持读取经过MD5加密的口令
--with-ssl-engine 启用OpenSSL的ENGINE支持

## 重启SSH

升级后已经要进行重启sshd，不重启的话，你会发现登录显示密码错误

```
systemctl restart sshd
```

## Configure error

configure: error: *** zlib.h missing – please install first or check config.log

```
 yum install -y zlib-devel
```

configure: error: *** working libcrypto not found, check config.log 

```
yum install -y openssl-devel
```

configure: error: no acceptable C compiler found in $PATH

```
yum install -y gcc
```

configure: error: *** OpenSSL headers missing – please install first or check config.log

```
yum install -y openssl-devel
```



```
KexAlgorithms diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1,diffie-hellman-group-exchange-sha256,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group1-sha1,curve25519-sha256@libssh.org
```

## SSL&SSH

SSL(Secure Sockets Layer 安全套接层),它提供使用 TCP/IP 的通信应用程序间的隐私与完整性。

“OpenSSH (OpenBSD Secure Shell) 是一套使bai用ssh协议，通过计算机网du络，提供加密通讯会话的计算机程序zhi” 

ssl是通讯链路的附加层。可以包含很多协议。https, ftps, .....

ssh只是加密的shell，最初是用来替代telnet的。通过port forward，也可以让其他协议通过ssh的隧道而起到加密的效果。

OpenSSL------一个C语言函数库，是对SSL协议的实现。

OpenSSH-----是对SSH协议的实现。

ssh 利用 openssl 提供的库。openssl 中也有个叫做 openssl 的工具，是 openssl 中的库的命令行接口。

从编译依赖上看：

openssh依赖于openssl，没有openssl的话openssh就编译不过去，也运行不了。

HTTPS可以使用TLS或者SSL协议，而openssl是TLS、SSL协议的开源实现，提供开发库和命令行程序。openssl很优秀，所以很多涉及到数据加密、传输加密的地方都会使用openssl的库来做。