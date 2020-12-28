1、先下载依赖包，要不后面make会出现报错

2、去官网下载所需版本

https://www.python.org/ftp/python/ 

3、执行脚本安装

4、验证安装成功 

Python3默认自带pip

```
Python3 -V
pip3 -V
```

pip2安装

```
curl https://bootstrap.pypa.io/get-pip.py | python
```

pip3 升级

```
pip3 install --upgrade pip
```

virtualenv

```
pip3 install virtualenv
virtualenv .env
source .env/bin/activate
pip install -r requirements.txt
```

退出虚拟环境

```
deactivate
```

指定不通版本的虚拟环境

```
virtualenv -p /usr/local/bin/python3 .env  # 通过选择不同版本的Python进行创建不同的虚拟环境
```

