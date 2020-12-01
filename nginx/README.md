**创建启动文件**

```
vim /usr/lib/systemd/system/nginx.service
```

**nginx.service**

```
[Unit]                                                       ## 对服务的说明
Description=nginx - high performance web server              ## 描述服务
After=network.target remote-fs.target nss-lookup.target      ## 描述服务类别

[Service]                                                    ## 服务的一些具体运行参数的设置
Type=forking                                                 ## 后台运行的形式
PIDFile=/var/log/nginx/nginx.pid                            ## PID文件的路径
ExecStartPre=/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf   ## 启动准备
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf         ## 启动命令
ExecReload=/usr/local/nginx/sbin/nginx -s reload                                  ## 重启命令
ExecStop=/usr/local/nginx/sbin/nginx -s stop                                      ## 停止命令
ExecQuit=/usr/local/nginx/sbin/nginx -s quit                                      ## 快速停止
PrivateTmp=true                                                                   ## 给服务分配临时空间

[Install]
WantedBy=multi-user.target       ## 服务用户的模式 
```

**添加执行权限**

```
chmod +x /usr/lib/systemd/system/nginx.service
```

**重载systemctl命令** !!!

```
systemctl daemon-reload
```

**命令**

```
systemctl start nginx.service
systemctl stop nginx.service
systemctl reload nginx.service
```



通过`nginx -V` 查看安装配置信息

```
[root@15b883 ~]# nginx -V
nginx version: nginx/1.18.0
built by gcc 4.8.5 20150623 (Red Hat 4.8.5-44) (GCC)
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx/ --sbin-path=/usr/local/nginx//sbin/nginx --conf-path=/usr/local/nginx//conf/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/logs/nginx/nginx.pid --with-http_stub_status_module --with-http_ssl_module --user=nginx --group=nginx
```

