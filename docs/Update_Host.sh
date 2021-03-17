#!/usr/bin/env bash
## 1 update zlib
## 2 update openssl
## 3 update openssh
##

package=/opt/
ZLIB_V=zlib-1.2.11
OpenSSH_V=openssh-8.3p1
OpenSSL_V=openssl-1.1.1g

Update_Zlib(){
  cd $package$ZLIB_V
  ./configure --prefix=/usr/local/zlib
  make && make install
}

Update_OpenSSL(){
  cd $package$OpenSSL_V
  ./config --prefix=/usr/local/ssl -d shared
  make && make install
  echo '/usr/local/ssl/lib' >> /etc/ld.so.conf
  ldconfig -v ##注：执行ldconfig -v有些报错，直接忽略即可
}

Update_OpenSSL(){
  cd $package$OpenSSH_V
  ./configure --prefix=/usr/local/openssh --with-zlib=/usr/local/zlib --with-ssl-dir=/usr/local/ssl
  make && make install
}



vim /usr/local/openssh/etc/sshd_config
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication yes

cp /opt/openssh-8.3p1/contrib/redhat/sshd.init /etc/init.d/sshd
chkconfig --add sshd  ##
cp /usr/local/openssh/etc/sshd_config /etc/ssh/sshd_config
cp /usr/local/openssh/sbin/sshd /usr/sbin/sshd
cp /usr/local/openssh/bin/ssh /usr/bin/ssh
cp /usr/local/openssh/bin/ssh-keygen /usr/bin/ssh-keygen
cp /usr/local/openssh/etc/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub


systemctl start sshd.service
systemctl enable sshd.service
