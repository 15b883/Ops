##/bin/bash 
##

# 官网进去选择版本
# https://www.python.org/ftp/python/ 

[ ! -d /opt/packages ]; mkdir -p /opt/packages
[ ! -d /usr/local/Python3 ]; mkdir -p /usr/local/Python3

# 依赖包
yum install -y zlib zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel \
tk-devel libffi-devel gcc make 

version_url=https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tar.xz

cd /opt/packages

wget ${version_url}

##
tar -xf Python-3.7.6
cd Python-3.7.0
./configure --prefix=/usr/local/Python3 --enable-optimizations
make && make install

# 
echo "export PATH=/usr/local/Python3/bin:$PATH" >> /etc/profile

#
source /etc/profile


# pip3 升级
# pip3 install --upgrade pip
# 下载virtualenv
# pip3 install virtualenv  
# 创建env
# virtualenv .env
# 环境下进入env
# source .env/bin/activate
# install packages
# pip install -r requirements.txt