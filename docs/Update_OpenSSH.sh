#!/bin/bash
##2019 03 12 15:45:55
###判断是否需要安装wget###
WGET=`rpm -qa | grep wget`
if [$WGET -z ];then
    yum install -y wget
fi
###准备参数###
file=/soft
zlib=http://www.zlib.net/zlib-1.2.11.tar.gz
openssl=https://www.openssl.org/source/openssl-1.0.2s.tar.gz
openssh=https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.0p1.tar.gz
###创建目录###
mkdir -p $file/zlib
mkdir -p $file/openssl
mkdir -p $file/openssh
###下载安装包###
cd $file
wget $zlib
wget $openssl
wget $openssh
###安装相关依赖包###
yum install -y gcc make perl zlib zlib-devel pam pam-devel
###解压并进入到相关目录###
tar -xzf zlib*.tar.gz -C $file/zlib
tar -xzf openssl*.tar.gz -C $file/openssl
tar -xzf openssh*.tar.gz -C $file/openssh
###停止ssh服务，并卸载原有的openssh###
systemctl stop sshd
systemctl is-active sshd
rpm -e --nodeps `rpm -qa | grep openssh`
###安装zlib###
cd $file/zlib/zlib*
./configure --prefix=/usr/local/zlib
make
make test
make install
echo '/usr/local/zlib/lib' >> /etc/ld.so.conf.d/zlib.conf
ldconfig -v
###安装opensshl###
cd $file/openssl/openssl*
./config shared zlib
make
make test
make install
mv /usr/bin/openssl /usr/bin/openssl.bak
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl
ln -s /usr/local/ssl/include/openssl /usr/include/openssl
echo '/usr/local/ssl/lib' >> /etc/ld.so.conf.d/ssl.conf
ldconfig -v
openssl version -a
###升级openssh###
mv /etc/ssh /etc/ssh.bak
cd $file/openssh/openssh*
./configure --prefix=/usr/local/openssh --sysconfdir=/etc/ssh --with-ssl-dir=/usr/local/ssl --mandir=/usr/share/man --with-zlib=/usr/local/zlib
make
make install
/usr/local/openssh/bin/ssh -V
cp /soft/openssh/openssh*/contrib/redhat/sshd.init /etc/init.d/sshd
chmod u+x /etc/init.d/sshd
chkconfig --add sshd
chkconfig --list|grep sshd
cp /soft/openssh/openssh*/sshd_config /etc/ssh/sshd_config
sed -i 's/Subsystem/#Subsystem/g' /etc/ssh/sshd_config
echo 'Subsystem sftp /usr/local/openssh/libexec/sftp-server'>> /etc/ssh/sshd_config
cp /usr/local/openssh/sbin/sshd /usr/sbin/sshd
cp /usr/local/openssh/bin/ssh /usr/bin/
ssh -V
cp /usr/local/openssh/bin/ssh-keygen /usr/bin/ssh-keygen
sed -i 's/#PasswordAuthentication\ yes/PasswordAuthentication\ yes/g' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
service sshd restart
systemctl is-active sshd
