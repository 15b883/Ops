


## 创建目录，并将 RHEL 光盘内容复制到该目录中；
```
mkdir /os/
cp -r /run/media/it/RHEL-8-0-0-BaseOS-x86_64/* /os/
```
## 配置 yum 源配置文件
```
vim /etc/yum.repos.d/centos7_9.repo
#---------------------------------
[localrepo]  # 名字自定义
name=CentOS-7.9 # 名字自定义
baseurl=file:///os/BaseOS  # 挂载路径 可以是file,ftp,http，其中file,ftp为内网或本机上的文件路径，http为共网上的路径，必须要注意此处路径格式的书写
enable=1    # 开启yum仓库 1表示启用该repo，0为不启用
gpgcheck=0  # 0表示不检查， 默认不检查，检查的话要导入公钥和私钥
```



## 清除存储库中的所有临时文件，然后下载并缓存所有已知的存储库。
```
yum clean all
yum makecache 
yum repolist
```
## 测试（可以查询库中可用的软件包）
```
yum list bind
```

