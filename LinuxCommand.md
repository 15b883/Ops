# Linux

## For

```
for i in {1..5}; do  echo ${i}; done
```

## if

```
if [ `rpm -qa|grep -c gcc` -eq 1 ]; then echo "yes" ; else echo "no"; fi
```

## 深度查询目录大小

```
[root@15b883 ~]# du -ach --max-depth=1 /opt/
28M	/opt/package
28M	/opt/
28M	总用量
```

## 统计目录下面有多少个文件
```
[root@15b883 ~]# ls -l /usr/local/ |grep "^-" |wc -l
0
```

## 统计目录下面有多少个目录
```
[root@15b883 ~]# ls -l /usr/local/ |grep "^d" |wc -l
13
```

## 根据命令查找软件包名称
```
rpm -qf  $(which ps)
rpm -ivh file rpm ## 安装rpm包
rpm -e file.rpm  ## 卸载rpm包
rpm -qR tree  #R的意思就是requires就是依赖哪些软件包
```

## Linux bash64 加密解密

```
➜  ~ echo -n 'YWRtaW4=' | base64
WVdSdGFXND0=
➜  ~ echo -n 'YWRtaW4=' | base64 -D
admin%
```

## wget 类比curl
```
wget -O - -q https://baidu.com
相当于curl
```





```
if [ ! -d "$install_dir" ]; then
  mkdir -p "$install_dir"
fi

find . -name '*.profclang?' -exec rm -f {} ';'

echo "3ROt@>7=f^Ah2$&0:-" | passwd --stdin root
echo "root:3ROt@>7=f^Ah2$&0:-" | chpasswd 


## 查看链接状态
netstat -an | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
## 查看连接你服务器 top10 用户端的 IP 地址
netstat -nat | awk '{print $5}' | awk -F ':' '{print $1}' | sort | uniq -c | sort -rn | head -n 10
## 在远程机器上运行一段脚本。这条命令最大的好处就是不用把脚本拷到远程机器上。
ssh user@server bash < /data/scripts/script.sh
## 非交互式创建用户
useradd zhangsan && echo 123456|passwd --stdin zhangsan #新建用户
\cp /etc/sudoers{,.ori}
echo "zhangsan  ALL=(ALL)  NOPASSWD:ALL">>/etc/sudoers
visudo -c

usermod -G wheel zhangsan  #加入wheel组
useradd -g wheel wangwu && echo xdjr0lxGu@|passwd --stdin wangwu
## 


## 文件下载
wget url/file
curl -O url/file
## 执行命令
curl -L https://raw.github.com/creationix/nvm/master/install.sh | sh
wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh
## rpm 
rpm -ivh xxx.rpm   #安装rpm包
rpm -qa |grep xxx  #过滤查看
rpm -e xxx.rpm     #卸载rpm包
## 临时修改Linux字符集
export LANG=en_US.UTF-8 
echo $LANG  #查看字符集
## 
[root@15b883(PRO)~]# tail -6 /etc/profile
export BIZENVFLAG=0     #生产环节
#export BIZENVFLAG=9     #开发环境
case $BIZENVFLAG in
 0) PS1='[\u@\h(\e[31;47mPRO\e[m)\W]\$ ';;
 9) PS1='[\u@\h(DEV)\W]\$ ';;
esac
[root@15b883(PRO)~]#
[root@15b883(PRO)~]#

查看本地私网IP
echo $(ip addr show eth0 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)

随机生成32字符串
tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></";.,[]=-' < /dev/urandom | fold -w 32 | head -n 1


杀掉运行8080端口的进程
lsof -i :8080 | awk '{l=$2} END {print l}' | xargs kill

显示每个IP到端口80的连接数量
clear;while x=0; do clear;date;echo "";echo "  [Count] | [IP ADDR]";echo "-------------------";netstat -np|grep :80|grep -v LISTEN|awk '{print $5}'|cut -d: -f1|uniq -c; sleep 5;done

shh server10
 ~/.ssh/config
Host server10
  Hostname 1.2.3.4
  IdentityFile ~/backups/.ssh/id_dsa
  user foobar
  Port 30000
  ForwardX11Trusted yes
  TCPKeepAlive yes


列出头十个最耗内存的进程
ps aux | sort -nk +4 | tail

## Python实现http服务
python -m SimpleHTTPServer
一句话实现一个HTTP服务，把当前目录设为HTTP服务目录，可以通过http://localhost:8000访问 这也许是这个星球上最简单的HTTP服务器的实现了。
查看公网IP（本地\公有云都能看到）
http://ifconfig.io/
curl http://ifconfig.io/
curl ip.sb

cat >>/etc/profile<<EOF
# JDK ENV
export JAVA_HOME=/usr/local/jdk1.8.0_212
export JRE_HOME=${JAVA_HOME}/jre  
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib  
export PATH=${JAVA_HOME}/bin:$PATH
EOF
cat >>/etc/profile<<EOF
# MVN ENV
export MVN_HOME=/usr/local/apache-maven-3.6.3
export PATH=${MVN_HOME}/bin:$PATH
EOF

bash <(curl -s -S -L https://xxxx.sh) 
curl https://xxxx/install.sh | sh
curl -sSL https://xxxx/deploy |bash -s
wget -qO- https://xxxx/install.sh | sh

## /etc/profile  环境变量
## 用户登录的时候执行sh脚本的顺序，每次登录的时候都会完全执行的
/etc/profile.d/file
/etc/profile
/etc/bashrc
/root/.bashrc
/root/.bash_profile
用户脚本，在用户登陆后执行，只有用户权限，所以只能执行用户权限下的程序，不登录就不会执行。
## /etc/rc.local 开机自启动
系统脚本，系统启动后自动执行，与是否登陆无关，所以优先级高于profile，可以指定执行程序的权限
## 自定义脚本：my.bash
sudo mv my.sh /etc/init.d/
cd /etc/init.d/
sudo update-rc.d my.sh defaults 90  ## 90表明一个优先级，越高表示执行的越晚
sudo update-rc.d -f my.sh remove  ## 移除脚本

设置环境变量的脚本，可以放在profile.d目录下面，但开机执行任务不应该放在profile.d目录下，因为每次登陆都会执行profile.d目录下的文件，会导致重复执行，
设置开机启动任务，应该放在rc.local中执行，它只会在系统启动时执行一次。
   ## 第三方安装包都放到/usr/local/file
   ## echo "export PATH=/usr/local/file/bin:$PATH" >> /etc/profile
   ## source /etc/profile
   ## groupadd -r nginx && useradd -s /sbin/nologin -g nginx -r nginx ##服务使用账户
   [ ! -d /opt/package ] && mkdir -p /opt/package
   [ ! -d /.root/scripts ] && mkdir -p /.root/scripts
   ssh-keygen -t rsa -b 4096 -P '' -f ~/.ssh/id_rsa > /dev/null 2>&1
   ## ssh-copy-id -i .ssh/id_dsa.pub root@172.16.1.41
   touch ~/.ssh/authorized_keys 
   


## 推push 把本地/tmp下的syaving 拷贝到41的/tmp
scp  -P22 -r -p /tmp/syaving syaving@10.0.0.1:/tmp
## 拉pull 把10.0.0.7下的/tmp/syaving拷贝到本地/opt/下
scp -P22 -rp root@10.0.0.7:/tmp/syaving /opt/ 
## 注意：拷贝权限为连接的用户对应的权限
-rp 拷贝目录属性不变
-P （大写，注意和ssd命令的不同）接端口，默认22端口是可以省略-P22
-r 递归，表示拷贝目录
-p 表示再拷贝前后保持文件或者目录属性
-l limit 限制速度
/tmp/syaving 为本地的目录。
“@”前为用户名
“@”后为要连接的服务器ip。
ip后的：/tmp目录，为远端的目标目录。
以上命令作用是把本地/tmp/syaving拷贝到远端服务器10.0.0.143的/tmp 目录:
```

