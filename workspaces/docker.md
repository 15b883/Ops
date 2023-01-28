## 安装需要的软件包

yum-util 提供yum-config-manager功能，另两个是devicemapper驱动依赖

```
yum install -y yum-utils device-mapper-persistent-data lvm2
```

## 设置 yum 源

设置一个yum源，下面两个都可用

```shell
yum-config-manager --add-repo http://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

## 选择docker版本并安装 

选择docker版本并安装 

```shell
# 查看可用版本有哪些
yum list docker-ce --showduplicates | sort -r
# 选择一个版本并安装：yum install docker-ce-版本号
yum -y install docker-ce.x86_64 3:20.10.23-3.el7
```

## 启动并设置开机自启动

```shell
systemctl enable docker && systemctl start docker 
```

## 国内加速镜像下载

```shell
# cat > /etc/docker/daemon.json << EOF
{
  "registry-mirrors": ["https://b9pmyelo.mirror.aliyuncs.com"]
}
EOF
systemctl restart docker
```



## docker-compose

https://github.com/docker/compose/releases 下载下来

https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-linux-x86_64

重命名

```shell
mv docker-compose-linux-x86_64 /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

