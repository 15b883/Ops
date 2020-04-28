

## 执行命令

```
ansible-playbook -i hosts -u root test.sh
 -u REMOTE_USER, --user=REMOTE_USER  
＃ ssh 连接的用户名
 -k, --ask-pass    
＃ssh登录认证密码
 -s, --sudo           
＃sudo 到root用户，相当于Linux系统下的sudo命令
 -U SUDO_USER, --sudo-user=SUDO_USER    
＃sudo 到对应的用户
 -K, --ask-sudo-pass     
＃用户的密码（—sudo时使用）
 -T TIMEOUT, --timeout=TIMEOUT 
＃ ssh 连接超时，默认 10 秒
 -C, --check      
＃ 指定该参数后，执行 playbook 文件不会真正去执行，而是模拟执行一遍，然后输出本次执行会对远程主机造成的修改

 -e EXTRA_VARS, --extra-vars=EXTRA_VARS    
＃ 设置额外的变量如：key=value 形式 或者 YAML or JSON，以空格分隔变量，或用多个-e
 -f FORKS, --forks=FORKS    
＃ 进程并发处理，默认 5
 -i INVENTORY, --inventory-file=INVENTORY   
＃ 指定 hosts 文件路径，默认 default=/etc/ansible/hosts
 -l SUBSET, --limit=SUBSET    
＃ 指定一个 pattern，对- hosts:匹配到的主机再过滤一次
 --list-hosts  
＃ 只打印有哪些主机会执行这个 playbook 文件，不是实际执行该 playbook
 --list-tasks   
＃ 列出该 playbook 中会被执行的 task
 --private-key=PRIVATE_KEY_FILE   
＃ 私钥路径
 --step    
＃ 同一时间只执行一个 task，每个 task 执行前都会提示确认一遍
 --syntax-check  
＃ 只检测 playbook 文件语法是否有问题，不会执行该 playbook 
 -t TAGS, --tags=TAGS   
＃当 play 和 task 的 tag 为该参数指定的值时才执行，多个 tag 以逗号分隔
 --skip-tags=SKIP_TAGS   
＃ 当 play 和 task 的 tag 不匹配该参数指定的值时，才执行
 -v, --verbose   
＃输出更详细的执行过程信息，-vvv可得到所有执行过程信息。
```

