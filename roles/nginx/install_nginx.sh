#!/bin/bash

#######################################################################################################
#0. 安装编译工具、依赖包
#1. 新建的用户组和用户主要是在编译配置的时候指定nginx运行的用户和用户组。这样指定后以后配置使用也方便
#2. 下载安装包 首先登录nginx官网http://nginx.org/download/确定你要下载的安装包  eg:nginx-1.13.1.tar.gz
#3. 配置编译和安装路径 ./configure --prefix=/usr/local/nginx
#4. 编译并安装
#5. 生产启动脚本和重启脚本
#######################################################################################################
install_dir='/opt/package/'
conf_dir='/usr/local/nginx/'
package=nginx-1.18.0.tar.gz
dir=nginx-1.18.0

# create directory
[ ! -d "$install_dir" ] && mkdir -p "$install_dir"
[ ! -d "$conf_dir" ] && mkdir -p "$conf_dir"
[ ! -d /var/log/nginx/ ] && mkdir -p /var/log/nginx/
[ ! -d /usr/local/nginx/conf/layer7 ] && mkdir -p /usr/local/nginx/conf/layer7

#install make package software
yum -y install gcc gcc-c++ autoconf automake \
       zlib zlib-devel openssl openssl-devel pcre-devel \
       install wget htop nmap uzip tree dos2unix

#user group
groupadd -r nginx && useradd -s /sbin/nologin -g nginx -r nginx


#install nginx package

cd ${install_dir}

if [ ! -f "$package" ]; then wget http://nginx.org/download/"${package}" ; fi
if [ ! -d "${install_dir}""${dir}" ]; then tar zvxf "${package}" ;fi


#make install

echo `pwd`
cd "${install_dir}""${dir}"
./configure \
--prefix=${conf_dir} \
--sbin-path=${conf_dir}/sbin/nginx \
--conf-path=${conf_dir}/conf/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/log/nginx/nginx.pid \
--with-http_stub_status_module  \
--with-http_ssl_module \
--user=nginx \
--group=nginx   && make &&  sudo make install

#清理磁盘，
#===
#进入安装目录并执行脚本

cd ${conf_dir}/
echo "最后一步，以后你可以直接使用 nginx (-s restart/stop)管理nginx服务"
cp -f sbin/nginx /sbin/nginx
#nginx -s stop
nginx
#
echo "  "
echo "  "
netstat -ntpl |grep 80
exit 0
