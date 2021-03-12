1、执行安装脚本

2、编辑`/usr/local/redis/redis.conf`配置文件；
看情况修改

```
daemonize  yes  ## 后台运行
logfile "/var/logs/redis/redis.log"  ## 日志文件，需要事先创建这个文件
requirepass foobared ## 设置密码
bind 127.0.0.1  ## 端口绑定
```

3、`redis.serivce`移动到`/usr/lib/systemd/system`

注意文件路径

把编辑好的文件移动到`/usr/lib/systemd/system`目录下面

`````
chmod +x /usr/lib/systemd/system/redis.service
`````

注意：如果第一次启动不是用的systemctl方式启动，一定要使用原来方式把redis关闭了再使用systemctl启动

```
systemctl daemon-reload
systemctl start redis.service   #启动服务
systemctl restart redis.service   #重新启动服务
systemctl status redis.service   #查看服务当前状态
systemctl enable redis.service   #设置开机自启动
systemctl disable redis.service   #停止开机自启动
```

关闭防火墙，或者打开相关端口

```
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 6379 -j ACCEPT
service iptables save
```

设定密码

此设定方式会在命令行暴露密码

```
127.0.0.1:6379> config set requirepass 123456
```

验证

```
127.0.0.1:6379> keys *
(error) NOAUTH Authentication required.
127.0.0.1:6379> auth 123456
OK
127.0.0.1:6379> keys *
1) "key"
2) "key2"
```

redis命令

```
127.0.0.1:6379> set name lisi 
OK
127.0.0.1:6379> get name
"lisi"
127.0.0.1:6379> del name
(integer) 1
127.0.0.1:6379> get name
(nil)
```

远程连接

```
yum install epel-release
yum install redis
redis-cli -h 10.0.0.1 -p 6379
```