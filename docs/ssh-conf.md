以主机A连接主机B为例，主机A为SSH客户端，主机B为SSH服务端。

**在服务端即主机B上：**

> - /etc/ssh/sshd_config ：ssh服务程序sshd的配置文件。
> - /etc/ssh/ssh_host_*  ：服务程序sshd启动时生成的服务端公钥和私钥文件。如ssh_host_rsa_key和ssh_host_rsa_key.pub。
> - ​                 ：其中.pub文件是主机验证时的host key，将写入到客户端的~/.ssh/known_hosts文件中。
> - ​                 ：**其中私钥文件严格要求权限为600，若不是则sshd服务可能会拒绝启动。**
> - ~/.ssh/authorized_keys：保存的是基于公钥认证机制时来自于客户端的公钥。在基于公钥认证机制认证时，服务端将读取该文件。

**在客户端即主机A上：**

> - /etc/ssh/ssh_config   ：客户端的全局配置文件。
> - ~/.ssh/config        ：客户端的用户配置文件，生效优先级高于全局配置文件。一般该文件默认不存在。该文件对权限有严
> - ​                 ：格要求只对所有者有读/写权限，对其他人完全拒绝写权限。
> - ~/.ssh/known_hosts  ：保存主机验证时服务端主机host key的文件。文件内容来源于服务端的ssh_host_rsa_key.pub文件。
> - /etc/ssh/known_hosts：全局host key保存文件。作用等同于~/.ssh/known_hosts。
> - ~/.ssh/id_rsa        ：客户端生成的私钥。由ssh-keygen生成。**该文件严格要求权限，当其他用户对此文件有可读权限时，**
> - ​                 **：ssh将直接忽略该文件。**
> - ~/.ssh/id_rsa.pub    ：私钥id_rsa的配对公钥。对权限不敏感。当采用公钥认证机制时，该文件内容需要复制到服务端的
> - ​                 ：~/.ssh/authorized_keys文件中。
> - ~/.ssh/rc           ：保存的是命令列表，这些命令在ssh连接到远程主机成功时将第一时间执行，执行完这些命令之后才
> - ​                 ：开始登陆或执行ssh命令行中的命令。
> - /etc/ssh/rc          ：作用等同于~/.ssh/rc。



## sshd_config

```
[root@xuexi ~]# cat /etc/ssh/sshd_config

#Port 22                # 服务端SSH端口，可以指定多条表示监听在多个端口上
#ListenAddress 0.0.0.0  # 监听的IP地址。0.0.0.0表示监听所有IP
Protocol 2              # 使用SSH 2版本
 
#####################################
#          私钥保存位置               #
#####################################
# HostKey for protocol version 1
#HostKey /etc/ssh/ssh_host_key      # SSH 1保存位置/etc/ssh/ssh_host_key
# HostKeys for protocol version 2
#HostKey /etc/ssh/ssh_host_rsa_key  # SSH 2保存RSA位置/etc/ssh/ssh_host_rsa _key
#HostKey /etc/ssh/ssh_host_dsa_key  # SSH 2保存DSA位置/etc/ssh/ssh_host_dsa _key
 
 
###################################
#           杂项配置               #
###################################
#PidFile /var/run/sshd.pid        # 服务程序sshd的PID的文件路径
#ServerKeyBits 1024               # 服务器生成的密钥长度
#SyslogFacility AUTH              # 使用哪个syslog设施记录ssh日志。日志路径默认为/var/log/secure
#LogLevel INFO                    # 记录SSH的日志级别为INFO
 
###################################
#   以下项影响认证速度               #
###################################
#UseDNS yes                       # 指定是否将客户端主机名解析为IP，以检查此主机名是否与其IP地址真实对应。默认yes。
                                  # 由此可知该项影响的是主机验证阶段。建议在未配置DNS解析时，将其设置为no，否则主机验证阶段会很慢
 
###################################
#   以下是和安全有关的配置           #
###################################
#PermitRootLogin yes              # 是否允许root用户登录
#GSSAPIAuthentication no          # 是否开启GSSAPI身份认证机制，默认为yes
#PubkeyAuthentication yes         # 是否开启基于公钥认证机制
#AuthorizedKeysFile  .ssh/authorized_keys  # 基于公钥认证机制时，来自客户端的公钥的存放位置
PasswordAuthentication yes        # 是否使用密码验证，如果使用密钥对验证可以关了它
#PermitEmptyPasswords no          # 是否允许空密码，如果上面的那项是yes，这里最好设置no
#MaxSessions 10                   # 最大客户端连接数量
#LoginGraceTime 2m                # 身份验证阶段的超时时间，若在此超时期间内未完成身份验证将自动断开
#MaxAuthTries 6                   # 指定每个连接最大允许的认证次数。默认值是6。
                                  # 如果失败认证次数超过该值一半，将被强制断开，且生成额外日志消息。
MaxStartups 10                    # 最大允许保持多少个未认证的连接。默认值10。

###################################
#   以下可以自行添加到配置文件        #
###################################
DenyGroups  hellogroup testgroup  # 表示hellogroup和testgroup组中的成员不允许使用sshd服务，即拒绝这些用户连接
DenyUsers   hello test            # 表示用户hello和test不能使用sshd服务，即拒绝这些用户连接
 
###################################
#   以下一项和远程端口转发有关        #
###################################
#GatewayPorts no                  # 设置为yes表示sshd允许被远程主机所设置的本地转发端口绑定在非环回地址上
                                  # 默认值为no，表示远程主机设置的本地转发端口只能绑定在环回地址上，见后文"远程端口转发"
```

## SSH_config

```
# Host *                              # Host指令是ssh_config中最重要的指令，只有ssh连接的目标主机名能匹配此处给定模式时，
                                      # 下面一系列配置项直到出现下一个Host指令才对此次连接生效
#   ForwardAgent no
#   ForwardX11 no
#   RhostsRSAAuthentication no
#   RSAAuthentication yes
#   PasswordAuthentication yes     # 是否启用基于密码的身份认证机制
#   HostbasedAuthentication no     # 是否启用基于主机的身份认证机制
#   GSSAPIAuthentication no        # 是否启用基于GSSAPI的身份认证机制
#   GSSAPIDelegateCredentials no
#   GSSAPIKeyExchange no
#   GSSAPITrustDNS no
#   BatchMode no                   # 如果设置为"yes"，将禁止passphrase/password询问。比较适用于在那些不需要询问提供密
                                   # 码的脚本或批处理任务任务中。默认为"no"。
#   CheckHostIP yes
#   AddressFamily any
#   ConnectTimeout 0
#   StrictHostKeyChecking ask        # 设置为"yes"，ssh将从不自动添加host key到~/.ssh/known_hosts文件，
                                     # 且拒绝连接那些未知的主机(即未保存host key的主机或host key已改变的主机)。
                                     # 它将强制用户手动添加host key到~/.ssh/known_hosts中。
                                     # 设置为ask将询问是否保存到~/.ssh/known_hosts文件。
                                     # 设置为no将自动添加到~/.ssh/known_hosts文件。
#   IdentityFile ~/.ssh/identity     # ssh v1版使用的私钥文件
#   IdentityFile ~/.ssh/id_rsa       # ssh v2使用的rsa算法的私钥文件
#   IdentityFile ~/.ssh/id_dsa       # ssh v2使用的dsa算法的私钥文件
#   Port 22                          # 当命令行中不指定端口时，默认连接的远程主机上的端口
#   Protocol 2,1
#   Cipher 3des                      # 指定ssh v1版本中加密会话时使用的加密协议
#   Ciphers aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,aes128-cbc,3des-cbc  # 指定ssh v1版本中加密会话时使用的加密协议
#   MACs hmac-md5,hmac-sha1,umac-64@openssh.com,hmac-ripemd160
#   EscapeChar ~
#   Tunnel no
#   TunnelDevice any:any
#   PermitLocalCommand no    # 功能等价于~/.ssh/rc，表示是否允许ssh连接成功后在本地执行LocalCommand指令指定的命令。
#   LocalCommand             # 指定连接成功后要在本地执行的命令列表，当PermitLocalCommand设置为no时将自动忽略该配置
                             # %d表本地用户家目录，%h表示远程主机名，%l表示本地主机名，%n表示命令行上提供的主机名，
                             # p%表示远程ssh端口，r%表示远程用户名，u%表示本地用户名。
#   VisualHostKey no         # 是否开启主机验证阶段时host key的图形化指纹
Host *
        GSSAPIAuthentication yes
```

