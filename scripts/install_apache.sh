#!/bin/sh
#
# install website https://mirrors.tuna.tsinghua.edu.cn/apache/httpd/
#

install_dir='/opt/package/'
conf_dir='/usr/local/apache/'
package=httpd-2.4.41.tar.gz
dir=httpd-2.4.41

#epel & package

Epel_Package(){
  yum install wget epel-release gcc gcc-c++ make uuid-devel libuuid-devel unzip pcre-devel -y
  wget https://centos7.iuscommunity.org/ius-release.rpm
  rpm -Uvh ius-release.rpm
  yum install httpd24u -y
}

#apr 中包含了一些通用的开发组件，包括 mmap，DSO 等等
#apr-util 该目录中也是包含了一些常用的开发组件。这些组件与 apr 目录下的相比，它们与 apache 的关系更加密切一些。比如存储段和存储段组，加密等等。
#apr-iconv 包中的文件主要用于实现 iconv 编码。目前的大部分编码转换过程都是与本地编码相关的。在进行转换之前必须能够正确地设置本地编码。

Install_Apr(){
  cd ${install_dir}
  wget http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-1.5.2.tar.gz
  tar zxvf apr-1.5.2.tar.gz
  cd apr-1.5.2
  ./configure --prefix=/usr/local/apr
  make && make install
}

Install_Apr-iconv(){
  cd ${install_dir}
  wget http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-iconv-1.2.1.tar.gz
  tar -zxvf apr-iconv-1.2.1.tar.gz
  cd apr-iconv-1.2.1
  ./configure --prefix=/usr/local/apr-iconv --with-apr=/usr/local/apr
  make && make install
}

Install_Apr-util(){
  cd ${install_dir}
  wget http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-util-1.5.4.tar.gz
  tar zxvf apr-util-1.5.4.tar.gz
  cd apr-util-1.5.4
  ./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr \
  --with-apr-iconv=/usr/local/apr-iconv/bin/apriconv
  make && make install
}


Install_Apache(){
  cd ${install_dir}

  if [ ! -f "$package" ]; then
  wget https://mirrors.tuna.tsinghua.edu.cn/apache/httpd/"${package}"
  fi
  if [ ! -d "${install_dir}""${dir}" ]; then
  tar zvxf "${package}"
  fi
}

Make_Apache(){
  echo `pwd`
  cd "${install_dir}""${dir}"
  ./configure
  --prefix=${conf_dir}  \
  --enable-defalte --enable-expires \
  --enable-headers --enable-modules=most \
  --enable-so --with-mpm=worker \
  --enable-rewrite --with-apr=/usr/local/apr \
  --with-apr-util=/usr/local/apr-util \
  --with-pcre=/usr/local/pcre  &&  make &&  sudo make install
}



#########
Epel_Package
Install_Apr
Install_Apr-iconv
Install_Apr-util
Install_Apache
Make_Apache
