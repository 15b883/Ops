# Linux-ntp update version

system environment

```
CentOS 6.10
2.6.32-754.33.1.el6.x86_64
```

## check version

```shell
ntpd --version
```

## backup file



```shell
cp -ar /etc/ntp /etc/ntp.bak
cp /etc/ntp.conf /etc/ntp.conf.bak
cp /etc/init.d/ntpd /etc/init.d/ntpd.bak
cp /etc/sysconfig/ntpd /etc/sysconfig/ntpd.bak
cp /etc/sysconfig/ntpdate /etc/sysconfig/ntpdate.bak
```

## install dependent packages

```shell
yum install -y gcc gcc-c++ openssl-devel libstdc++* libcap*
```

## upload package



## make install

```shell
./configure  \
--prefix=/usr \
--bindir=/usr/sbin \ 
--sysconfdir=/etc \
--enable-linuxcaps \
--with-lineeditlibs=readline \  
--enable-all-clocks \
--enable-parse-clocks \
--enable-clockctl

make && make install
```

## bootstrap self-start

``` shell
chkconfig ntpd on
```



> http://support.ntp.org/bin/view/Main/WebHome
>
> https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/
>
> http://www.ntp.org/downloads.html