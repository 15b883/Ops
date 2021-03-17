## download URL

http://www.openssh.com/portable.html

 https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/

##  Check

```shell
# check os version
# check ssh version
# check openssl version
# backup ssh openssl

[root@testenv ~]# ssh -V
OpenSSH_7.4p1, OpenSSL 1.0.2k-fips  26 Jan 2017
[root@testenv ~]# openssl version
OpenSSL 1.0.2k-fips  26 Jan 2017


openssl version -a ## 查看openssl安装位置
whereis 
which
rpm -ql

```

## Backup 

ssh openssl

```shell
mkdir /etc/ssh.bak
mv /etc/ssh/ /etc/ssh.bak/

# find / -name openssl
# mv /usr/bin/openssl /usr/bin/openssl_old
# mv /usr/lib64/openssl /usr/lib64/openssl_old
# mkdir /usr/lib/openssl_old
# mv /usr/lib/openssl mv/usr/lib/openssl_old
# mv /usr/include/openssl /usr/include/openssl_old
```

## update ssh

```
tar xf openssh-8.5p1.tar.gz  
cd openssh-8.5p1
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-ssl-dir=/usr/local/openssl --with-md5-passwords 

make && make install
```

--prefix 安装目录
--sysconfdir 配置文件目录
--with-ssl-dir 指定 OpenSSL 的安装目录
--with-privsep-path 非特权用户的chroot目录
--with-privsep-user=sshd 指定非特权用户为sshd
--with-zlib 指定zlib库的安装目录
--with-md5-passwords 支持读取经过MD5加密的口令
--with-ssl-engine 启用OpenSSL的ENGINE支持

## restart sshd

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



卸载完旧版本的openssh，再make install

```shell
rpm -qa | grep openssh 
rpm -e `rpm -qa` | grep openssh
```



```
/usr/local/zlib/lib:
libz.so.1 -> libz.so.1.2.11
	
##	
tar -xzvf zlib-1.2.11.tar.gz
cd zlib-1.2.11	
./configure --prefix=/usr/local/zlib
make
make test
make install
## 验证zlib安装是否成功
ll /usr/local/zlib
## 新建并编辑配置文件：
vi /etc/ld.so.conf.d/zlib.conf
加入如下内容后保存退出
/usr/local/zlib/lib
## 刷新库文件，加载刚才编译安装的zlib生成的库文件
ldconfig -v
```




升级过程中需要刷新lib库：ldconfig -v；
升级顺序：顺序是zlib库-> openssl -> openssh；

升级需要gcc、make、perl、zlib、zlib-devel、pam、pam-devel；



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