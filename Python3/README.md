## 依赖包

```
yum install -y 
zlib zlib-devel bzip2-devel openssl-devel \
ncurses-devel sqlite-devel readline-devel \
tk-devel libffi-devel gcc make wget 
```

## 官网下载所需版本

https://www.python.org/ftp/python/ 

```
wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tar.xz
tar -xf Python-3.7.6
cd Python-3.7.0
[ ! -d /usr/local/Python3 ]; mkdir -p /usr/local/Python3
./configure --prefix=/usr/local/Python3 --enable-optimizations
make && make install
#
echo "export PATH=/usr/local/Python3/bin:$PATH" >> /etc/profile
source /etc/profile
```

Python3默认自带pip

pip2安装

```
curl https://bootstrap.pypa.io/get-pip.py | python
```

## pip3 升级

```
pip3 install --upgrade pip
```

## virtualenv

```
pip3 install virtualenv
```

### 创建env

```
virtualenv .env
```

### 进入env

```
source .env/bin/activate
```

### install packages

```
pip install -r requirements.txt
```

### 退出虚拟环境

```
deactivate
```

## 指定不通版本的虚拟环境

```
virtualenv -p /usr/local/bin/python3 .env 
```

