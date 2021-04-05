# linux-find

Find查找 - 搜索目录层次结构中的文件

**命令格式**

```
find [-H] [-L] [-P] [-D debugopts] [-Olevel] [path...] [expression]
```



```
-type d 类型 目录  查询目录
/  表示目录本身
/* 表示目录下的
-a 为and标识并且
-o 为or两边有一个成立即可
-type    b/d/c/p/l/f         #查是块设备、目录、字符设备、管道、符号链接、普通文件
-name “文件名”
-mtime n #n为数字，意义为在n天之前的【一天之内】被modification过的档案 
-mmin  n  File's data was last modified n minutes ago. 按分钟查找
时间 按修改时间查找，时间数字 +7 7天以前，7 第7天，-7 最近7天
-atime n #n为数字，意义为在n天之前的【一天之内】被access过的档案
-ctime n #n为数字，意义为在n天之前的【一天之内】被change过状态的档案
-newer file  #为一个存在的档案，意思是说，只要档案比file还要新，就会被列出来 
- size 查长度为n块[或n字节]的文件
-follow 如果遇到符号链接文件，就跟踪链接所指的文件
find  .  -perm -007   -exec ls -l {} \;   #查所有用户都可读写执行的文件同-perm 777

mv `find /oldboy -type f "*.log" -mtime ＋7 -size +1M ` /tmp/
find ./ -maxdepth 1 -type d  查询深度为1级的目录
find . -maxdepth 1 -type d ! -name "." 查询深度为非点“.”的1级目录
! 取反。都查找的结果取反

逻辑    -and 条件与 -or 条件或

-print find命令将匹配的文件输出到标准输出。
-exec：对搜索的结果执行指定的shell命令。注意格式要正确："-exec 命令 {} \;"。注意“{}” 与\;之间有空格。
-ok 和- e x e c的作用相同，只不过以一种更为安全的模式来执行该参数所给出的s h e l l命令，在执行每一个命令之前，都会给出提示，让用户来确定是否执行。
-mount,-xdev : 只检查和指定目录在同一个档案系统下的档案，避免列出其它档案系统中的档案

-amin n   查找系统中最后N分钟访问的文件
-atime n  查找系统中最后n*24小时访问的文件
-cmin n   查找系统中最后N分钟被改变文件状态的文件
-ctime n  查找系统中最后n*24小时被改变文件状态的文件
-mmin n   查找系统中最后N分钟被改变文件数据的文件
-mtime n  查找系统中最后n*24小时被改变文件数据的文件

-amin -n : 在最近的 n 分钟内被读取过
-amin +n : 在 n 分钟之前被读取过
-anewer file : 比档案 file 更晚被读取过的档案
-atime -n : 在最近的 n 天内读取过的档案
-atime +n : 在 n 天前读取过的档案
-cmin -n : 在最近的 n 分钟内被修改过
-cmin +n : 在 n 分钟前被修改过
-cnewer file ：比档案 file 更新的档案
-ctime -n : 在最近的 n 天内修改过的档案
-ctime +n : 在 n 天前修改过的档案
-empty : 空的档案-gid n or -group name : gid 是 n 或是 group 名称是 name
-ipath p,-path p : 路径名称符合 p 的档案，ipath 会忽略大小写
-name name,-iname name : 档案名称符合 name 的档案。iname 会忽略大小写
-size n[cwbkMG] : 档案大小 为 n 个由后缀决定的数据块。其中后缀含义为：
b: 代表 512 位元组的区块（如果用户没有指定后缀，则默认为 b）
c: 表示字节数
k: 表示 kilo bytes （1024字节）
w: 字 （2字节）
M:兆字节（1048576字节）
G: 千兆字节 （1073741824字节）
-type c : 档案类型是 c 的档案。
d: 目录
c: 字型装置档案
b: 区块装置档案
p: 具名贮列
f: 一般档案
l: 符号连结
s: socket
-pid n : process id 是 n 的档案
你可以使用 () 将运算式分隔，并使用下列运算。
exp1 -and exp2
！ expr
-not expr
exp1 -or exp2
exp1,exp2
范例：
将目前目录及其子目录下所有延伸档名是 c 的档案列出来。
# find . -name "*.c"
将目前目录其其下子目录中所有一般档案列出
# find . -ftype f
将目前目录及其子目录下所有最近 20 天内更新过的档案列出
# find . -ctime -20
查当前目录下的所有普通文件
#find . -type f -exec ls -l {} \;

```



```
3.1 以名字查找
文件名选项是find命令最常用的选项，要么单独使用该选项，要么和其他选项一起使用。
可以使用某种文件名模式来匹配文件，记住要用引号将文件名模式引起来。
3.1.1 不管当前路径是什么，如果想要在自己的根目录$HOME中查找文件名符合*.txt的文件，
使用~作为' pathname参数，波浪号~代表了你的$HOME目录。
[root@syaving data]# find ~ -name "*.sh"
/root/shang.sh
[root@syaving data]# ls /root/
anaconda-ks.cfg  log.txt  shang.sh
3.1.2 想要在当前目录及子目录中查找所有的'*.txt'文件，可以用：
[root@syaving data]# tree backup/
backup/
└── cwrj
    ├── cwrj_2017-03-30_609005725.tar.gz
    ├── cwrj_2017-03-30_618818987.tar.gz
    ├── cwrj_2017-03-30_619974191.tar.gz
    └── cwrj_2017-03-30_936502643.tar.gz

1 directory, 4 files
[root@syaving data]# cd backup/
[root@syaving backup]# ls
cwrj
[root@syaving backup]# find . -name "cwrj*"
./cwrj
./cwrj/cwrj_2017-03-30_609005725.tar.gz
./cwrj/cwrj_2017-03-30_936502643.tar.gz
./cwrj/cwrj_2017-03-30_619974191.tar.gz
./cwrj/cwrj_2017-03-30_618818987.tar.gz
[root@syaving backup]#
3.1.3 想要的当前目录及子目录中查找文件名以一个大写字母开头的文件，可以用：
[root@syaving backup]# tree
.
└── cwrj
    ├── Abc
    ├── cwrj_2017-03-30_609005725.tar.gz
    ├── cwrj_2017-03-30_618818987.tar.gz
    ├── cwrj_2017-03-30_619974191.tar.gz
    ├── cwrj_2017-03-30_936502643.tar.gz
    └── ddd

3 directories, 4 files
[root@syaving backup]# find . -name "[A-Z]*"
./cwrj/Abc
[root@syaving backup]#
3.1.4 想要在/etc目录中查找文件名以host开头的文件，可以用：
[root@syaving ~]# find /etc -name "host*"
/etc/host.conf
/etc/hosts
/etc/hosts.allow
/etc/hosts.deny
/etc/selinux/targeted/active/modules/100/hostname
/etc/hostname
[root@syaving ~]#
3.1.5 想要查找$home目录中的文件，可以用：
 [root@syaving ~]# find ~ -name "*" 
/root
/root/.bash_logout
/root/.bash_profile
/root/.bashrc
/root/.cshrc
/root/.tcshrc
/root/anaconda-ks.cfg
/root/.bash_history
/root/.oracle_jre_usage
/root/.oracle_jre_usage/9f270fd1aa7e37a6.timestamp
/root/shang.sh
/root/.viminfo
/root/log.txt
[root@syaving ~]# find .
.
./.bash_logout
./.bash_profile
./.bashrc
./.cshrc
./.tcshrc
./anaconda-ks.cfg
./.bash_history
./.oracle_jre_usage
./.oracle_jre_usage/9f270fd1aa7e37a6.timestamp
./shang.sh
./.viminfo
./log.txt
3.1.6 如果想在当前目录查找文件名以两个小写字母开头，跟着是两个数字，最后是*.txt的文件，下面的命令就能够返回名为ax12.txt的文件
[root@syaving 13]# ll
total 196
-rwxr-xr-x 1 test test     40 Sep 13 19:13 13_1.txt
-rw-r--r-- 1 root root     14 Sep 13 19:06 13_2.txt
-rw-r--r-- 1 root root      0 Sep 13 19:31 ab12.txt
-rw-r--r-- 1 root root 190535 Jun 23 18:39 test.txt
[root@syaving 13]# find . -name "[a-z][a-z][0-9][0-9].txt"
./ab12.txt

3.2 以权限查看
如果希望按照文件权限模式来查找文件的话，可以采用-perm选项。你可能需要找到所有用户都具有执行权限的文件，或是希望查看某个用户目录下的文件权限类型。在使用这一选项的时候，最好使用八进制的权限表示法。
为了在当前目录下查找文件权限位为755的文件，即文件属主可以读、写、执行，其他用户可以读、执行的文件，可以用：
[root@syaving 13]# ll
total 8
-rwxr-xr-x 1 root root 40 Sep 13 19:13 13_1.txt
-rw-r--r-- 1 root root 14 Sep 13 19:06 13_2.txt
[root@syaving 13]# find . -perm 755
.
./13_1.txt
查找777权限文件
如果希望在当前目录下查找所有用户都可读、写、执行的文件（要小心这种情况），我们可以使用find命令的-perm选项。在八进制数字前面要加一个横杠-。在下面的命令中-perm代表按照文件权限查找，而‘007’和你在chmod命令的绝对模式中所采用的表示法完全相同。
3.3 忽略某个目录
如果在查找文件时希望忽略某个目录，因为你知道那个目录中没有你所要查找的文件，那么可以使用-prune选项来指出需要忽略的目录。在使用  - prune选项时要当心，因为如果你同时使用了-depth选项，那么-prune选项就会被find命令忽略。
如果希望在/ a p p s目录下查找文件，但不希望在/ a p p s / b i n目录下查找，可以用：
[root@syaving ~]# find /data -type f -name "22.log"
/data/update/22.log
/data/java/22.log
[root@syaving ~]# find /data -path "/data/update" -prune -o -type f -name "22.log"
/data/update
/data/java/22.log
3.4 以用户查找
例如，在$home目录中查找
文件属主为tomcat的文件，可以用：
[root@syaving 13]# ll
total 8
-rwxr-xr-x 1 test test 40 Sep 13 19:13 13_1.txt
-rw-r--r-- 1 root root 14 Sep 13 19:06 13_2.txt
[root@syaving 13]# find . -user test
./13_1.txt
[root@syaving 13]# find . -user test |xargs ls -ld
-rwxr-xr-x 1 test test 40 Sep 13 19:13 ./13_1.txt
3.5 在/etc目录下查找文件属主为uucp的文件：
$ find /etc -user uucp -print
3.6 为了查找属主帐户已经被删除的文件，可以使用-nouser选项。这样就能够找到那些属主
在/etc/passwd文件中没有有效帐户的文件。在使用-nouser选项时，不必给出用户名； find命令
能够为你完成相应的工作。
例如，希望在/home目录下查找所有的这类文件，可以用：
$ find /home -nouser -print


3.7 使用group和nogroup选项
就像u s e r和n o u s e r选项一样，针对文件所属于的用户组， f i n d命令也具有同样的选项，为
了在/ a p p s目录下查找属于a c c t s用户组的文件，可以用：
$ find /apps -group accts -print
要查找没有有效所属用户组的所有文件，可以使用n o g r o u p选项。下面的f i n d命令从文件
系统的根目录处查找这样的文件
$ fine/-nogroup-print

3.8 时间（time）
如果希望按照更改时间来查找文件，可以使用m t i m e选项。如果系统突然没有可用空间了，很有可能某一个文件的长度在此期间增长迅速，这时就可以用m t i m e选项来查找这样的文件。用减号-来限定更改时间在距今n日以内的文件，而用加号+来限定更改时间在距今n日以前的文件。
 	-amin n   查找系统中最后N分钟访问的文件
 	-atime n  查找系统中最后n*24小时访问的文件
 	-cmin n   查找系统中最后N分钟被改变文件状态的文件
 	-ctime n  查找系统中最后n*24小时被改变文件状态的文件
 	-mmin n   查找系统中最后N分钟被改变文件数据的文件
 	-mtime n  查找系统中最后n*24小时被改变文件数据的文件
[root@syaving ~]# find . -type f -amin -10    ##查看最后10分钟修改的文件
./disk.inf
./bak.sh
./.viminfo
[root@syaving ~]# find . -type d -amin -10    ##查看最后10分钟修改的文件夹

希望在系统根目录下查找更改时间在5日以内的文件，可以用：
$ find / -mtime -5 -print
为了在/ v a r / a d m目录下查找更改时间在3日以前的文件，可以用：
$ find /var/adm -mtime +3 -print
3.9 以文件长度来查找（block）
可以按照文件长度来查找文件，这里所指的文件长度既可以用块（block）来计量，也可以用字节来计量。以字节计量文件长度的表达形式为N c；以块计量文件长度只用数字表示即可。就我个人而言，我总是使用以字节计的方式，在按照文件长度查找文件时，大多数人都喜欢使用这种以字节表示的文件长度，而不用块的数目来表示，除非是在查看文件系统的大小，因为这时使用块来计量更容易转换。
按尺寸查找：
find / -size 1500c （查找1,500字节大小的文件，c表示字节）
find / -size +1500c （查找大于1,500字节大小的文件，+表示大于）    
find / -size -1500c （查找小于1,500字节大小的文件，-表示小于） 
注意：
c: 表示字节数
 
为了在当前目录下查找文件长度大于1 M字节的文件，可以用：
$ find . -size +1000000c 
为了在/ h o m e / a p a c h e目录下查找文件长度恰好为1 0 0字节的文件，可以用：
$ find /home/apache -size 100c 
为了在当前目录下查找长度超过1 0块的文件（一块等于5 1 2字节），可以用：
$ find . -size +10 

[root@syaving 13]# ll
total 196
-rwxr-xr-x 1 test test     40 Sep 13 19:13 13_1.txt
-rw-r--r-- 1 root root     14 Sep 13 19:06 13_2.txt
-rw-r--r-- 1 root root 190535 Jun 23 18:39 test.txt
[root@syaving 13]# find . -size -100c
.
./13_1.txt
./13_2.txt
[root@syaving 13]# find . -size +100c
./test.txt
3.10 depth
在使用f i n d命令时，可能希望先匹配所有的文件，再在子目录中查找。使用d e p t h选项就可以使f i n d命令这样做。这样做的一个原因就是，当在使用f i n d命令向磁带上备份文件系统时，希望首先备份所有的文件，其次再备份子目录中的文件。在下面的例子中， f i n d命令从文件系统的根目录开始，查找一个名为C O N . F I L E的文件。
它将首先匹配所有的文件然后再进入子目录中查找。
$ find / -name "CON.FILE" -depth -print

3.11 mount
在当前的文件系统中查找文件（不进入其他文件系统），可以使用f i n d命令的m o u n t选项。在下面的例子中，我们从当前目录开始查找位于本文件系统中文件名以X C结尾的文件：
$ find . -name "*.XC" -mount -print
3.12 exec或ok 
当匹配到一些文件以后，可能希望对其进行某些操作，这时就可以使用- e x e c选项。一旦f i n d命令匹配到了相应的文件，就可以用- e x e c选项中的命令对其进行操作（在有些操作系统中只允许- e x e c选项执行诸如l s或ls -l这样的命令）。大多数用户使用这一选项是为了查找旧文件并删除它们。这里我强烈地建议你在真正执行r m命令删除文件之前，最好先用l s命令看一下，确认它们是所要删除的文件。e x e c选项后面跟随着所要执行的命令，然后是一对儿{ }，一个空格和一个\，最后是一个分号。
为了使用e x e c选项，必须要同时使用p r i n t选项。如果验证一下f i n d命令，会发现该命令只输出从当前路径起的相对路径及文件名。
为了在/ l o g s目录中查找更改时间在5日以前的文件并删除它们，可以用：
$ find logs -type f -mtime +5 -exec rm {} \;
记住，在s h e l l中用任何方式删除文件之前，应当先查看相应的文件，一定要小心！
当使用诸如m v或r m命令时，可以使用- e x e c选项的安全模式。它将在对每个匹配到的文件进行操作之前提示你。在下面的例子中， f i n d命令在当前目录中查找所有文件名以. L O G结尾、更改时间在5日以上的文件，并删除它们，只不过在删除之前先给出提示。
[root@syaving ~]# find . -name "*."txt -exec ls -l {} \;
-rw-r--r-- 1 root root 68676 Apr  1 14:22 ./log.txt
-rw-r--r-- 1 root root 0 Apr  1 15:01 ./te23.txt
-rw-r--r-- 1 root root 22 Apr  1 17:52 ./test.txt
[root@syaving ~]# find . -name "*."txt -ok ls -l {} \;
< ls ... ./log.txt > ? y
-rw-r--r-- 1 root root 68676 Apr  1 14:22 ./log.txt
< ls ... ./te23.txt > ? y
-rw-r--r-- 1 root root 0 Apr  1 15:01 ./te23.txt
< ls ... ./test.txt > ? y
-rw-r--r-- 1 root root 22 Apr  1 17:52 ./test.txt
[root@syaving ~]#
3.13 查找字符串
find . -name '*.html' -exec grep 'mailto:'{}

3.14 xargs
在使用f i n d命令的- e x e c选项处理匹配到的文件时， f i n d命令将所有匹配到的文件一起传递给e x e c执行。不幸的是，有些系统对能够传递给e x e c的命令长度有限制，这样在f i n d命令运行几分钟之后，就会出现溢出错误。错误信息通常是“参数列太长”或“参数列溢出”。这就是
x a rg s命令的用处所在，特别是与f i n d命令一起使用。F i n d命令把匹配到的文件传递给x a rg s命令，而x a rg s命令每次只获取一部分文件而不是全部，不像- e x e c选项那样。这样它可以先处理最先获取的一部分文件，然后是下一批，并如此继续下去。在有些系统中，使用- e x e c选项会为处理每一个匹配到的文件而发起一个相应的进程，并非将匹配到的文件全部作为参数一次执行；这样在有些情况下就会出现进程过多，系统性能下降的问题，因而效率不高；而使用x a rg s命令则只有一个进程。另外，在使用x a rg s命令时，究竟是一次获取所有的参数，还是分批取得参数，以及每一次获取参数的数目都会根据该命令的选项及系统内核中相应的可调参数来确定。
让我们来看看x a rg s命令是如何同f i n d命令一起使用的，并给出一些例子。
下面的例子查找系统中的每一个普通文件，然后使用x a rg s命令来测试它们分别属于哪类文件：

下面的例子在/ a p p s / a u d i t目录下查找所有用户具有读、写和执行权限的文件，并收回相应
的写权限：
$ find /apps/audit -perm -7 -print | xargs chmod o-w
在下面的例子中，我们用g r e p命令在所有的普通文件中搜索d e v i c e这个词：
$ find / -type f -print | xargs grep "device"
在下面的例子中，我们用g r e p命令在当前目录下的所有普通文件中搜索Tomcat这个词：
[root@syaving ~]# find . -type f -name "*" |xargs grep "Tomcat"
./.bash_history:mkdir Tomcat/5050 -p
./.bash_history:cd Tomcat/5050/
./.bash_history:cd Tomcat/
./.bash_history:ls /data/Tomcat/5050/webapps/
./.bash_history:cd Tomcat/
注意，在上面的例子中， \用来取消f i n d命令中的*在s h e l l中的特殊含义
3.15 查询1级目录
[root@15b883 ~]# find ./ -maxdepth 1 -type d  #查询1级目录
./
./22222222:
./222
./:
./123
./44
./mkdir

[root@15b883 ~]# find . -maxdepth 1 -type d ! -name "."
./22222222:
./222
./:
./123
./44
./mkdir

#-print 将查找到的文件输出到标准输出
#-exec    command    {} \;       -----将查到的文件执行command操作,{} 和 \;之间有空格
#-ok 和-exec相同，只不过在操作前要询用户 ==================================================== -name    filename               #查找名为filename的文件
-perm                         #按执行权限来查找
-user     username              #按文件属主来查找
-group groupname              #按组来查找
-mtime    -n +n                 #按文件更改时间来查找文件，-n指n天以内，+n指n天以前
-atime     -n +n                #按文件访问时间来查GIN: 0px">-perm                          #按执行权限来查找
-user     username              #按文件属主来查找
-group groupname              #按组来查找
-mtime    -n +n                 #按文件更改时间来查找文件，-n指n天以内，+n指n天以前
-atime     -n +n                #按文件访问时间来查找文件，-n指n天以内，+n指n天以前 
-ctime     -n +n                #按文件创建时间来查找文件，-n指n天以内，+n指n天以前 
-nogroup                      #查无有效属组的文件，即文件的属组在/etc/groups中不存在
-nouser                       #查无有效属主的文件，即文件的属主在/etc/passwd中不存
-newer    f1 !f2                找文件，-n指n天以内，+n指n天以前 
-ctime     -n +n                #按文件创建时间来查找文件，-n指n天以内，+n指n天以前 
-nogroup                      #查无有效属组的文件，即文件的属组在/etc/groups中不存在
-nouser                       #查无有效属主的文件，即文件的属主在/etc/passwd中不存
-newer    f1 !f2                #查更改时间比f1新但比f2旧的文件
-type      b/d/c/p/l/f          #查是块设备、目录、字符设备、管道、符号链接、普通文件
-size       n[c]                #查长度为n块[或n字节]的文件
-depth                        #使查找在进入子目录前先行查找完本目录
-fstype                       #查更改时间比f1新但比f2旧的文件
-mount                        #查文件时不跨越文件系统mount点
-follow                       #如果遇到符号链接文件，就跟踪链接所指的文件
-cpio                         #对匹配的文件使用cpio命令，将他们备份到磁带设备中
-prune                        #忽略某个目录 ====================================================
$find    .     -name    "[A-Z]*"    -pri26nbsp;    
-prune                                #忽略某个目录 $find    .     -name    "[A-Z]*"    -print    #查以大写字母开头的文件
$find    /etc    -name    "host*"    -print #查以host开头的文件
$find    .    -name    "[a-z][a-z][0--9][0--9].txt"     -print    #查以两个小写字母和两个数字开头的txt文件
$find    . -type d    -print   打印目录结构
$find    .   !    -type    d    -print  打印非目录文件 find /usr/include -name '*.h' -exec grep AF_INEF6 {} \; 因grep无法递归搜索子目录，故可以和find相结合使用。 在/usr/include 所有子目录中的.h文件中找字串AF_INEF6
$find    .    -type l    -print $find    .    -size    +1000000c    -print         #查长度大于1Mb的文件
$find    .    -size    100c          -print        # 查长度为100c的文件
$find    .    -size    +10    -print               #查长度超过期作废10块的文件（1块=512字节） $cd /
$find    etc    home    apps     -depth    -print    | cpio    -ivcdC65536    -o    /dev/rmt0  #对匹配的文件使用cpio命令，将他们备份到磁带设备中
$find    /etc -name "passwd*"    -exec grep    "cnscn"    {}    \;    #看是否存在cnscn用户
$find . -name "yao*"    | xargs file
$find    . -name "yao*"    |    xargs    echo     "" > /tmp/core.log
$find    . -name "yao*"    | xargs    chmod    o-w ====================================================== find    -name april*                        在当前目录下查找以april开始的文件
find    -name    april*    fprint file          在当前目录下查找以april开始的文件，并把结果输出到file中
find    -name ap* -o -name may*    查找以ap或may开头的文件
find    /mnt    -name tom.txt    -ftype vfat    在/mnt下查找名称为tom.txt且文件系统类型为vfat的文件
find    /mnt    -name t.txt ! -ftype vfat     在/mnt下查找名称为tom.txt且文件系统类型不为vfat的文件
find    /tmp    -name wa* -type l             在/tmp下查找名为wa开头且类型为符号链接的文件
find    /home    -mtime    -2                   在/home下查最近两天内改动过的文件
find /home     -atime -1                    查1天之内被存取过的文件
find /home -mmin     +60                    在/home下查60分钟前改动过的文件
find /home    -amin    +30                    查最近30分钟前被存取过的文件
find /home    -newer    tmp.txt               在/home下查更新时间比tmp.txt近的文件或目录
find /home    -anewer    tmp.txt              在/home下查存取时间比tmp.txt近的文件或目录
find    /home    -used    -2                    列出文件或目录被改动过之后，在2日内被存取过的文件或目录
find    /home    -user cnscn                  列出/home目录内属于用户cnscn的文件或目录
find    /home    -uid    +501                   列出/home目录内用户的识别码大于501的文件或目录
find    /home    -group    cnscn                列出/home内组为cnscn的文件或目录
find    /home    -gid 501                     列出/home内组id为501的文件或目录
find    /home    -nouser                      列出/home内不属于本地用户的文件或目录
find    /home    -nogroup                     列出/home内不属于本地组的文件或目录
find    /home     -name tmp.txt     -maxdepth    4    列出/home内的tmp.txt 查时深度最多为3层
find    /home    -name tmp.txt    -mindepth    3    从第2层开始查
find    /home    -empty                       查找大小为0的文件或空目录
find    /home    -size    +512k                 查大于512k的文件
find    /home    -size    -512k                 查小于512k的文件
find    /home    -links    +2                   查硬连接数大于2的文件或目录
find    /home    -perm    0700                  查权限为700的文件或目录
find    /tmp    -name tmp.txt    -exec cat {} \;
find    /tmp    -name    tmp.txt    -ok    rm {} \; find     /    -amin     -10         # 查找在系统中最后10分钟访问的文件
find     /    -atime    -2           # 查找在系统中最后48小时访问的文件
find     /    -empty                # 查找在系统中为空的文件或者文件夹
find     /    -group    cat          # 查找在系统中属于 groupcat的文件
find     /    -mmin    -5           # 查找在系统中最后5分钟里修改过的文件
find     /    -mtime    -1          #查找在系统中最后24小时里修改过的文件
find     /    -nouser               #查找在系统中属于作废用户的文件
find     /    -user     fred         #查找在系统中属于FRED这个用户的文件

在/ l o g s目录中查找更改时间在5日以前的文件并删除它们：
$ find logs -type f -mtime +5 -exec    -ok    rm {} \; 
=================================================
查询当天修改过的文件
[root@book class]# find    ./    -mtime    -1    -type f    -exec    ls -l    {} \; 
=================================================
查询文件并询问是否要显示
[root@book class]# find    ./    -mtime    -1    -type f    -ok    ls -l    {} \;  
< ls ... ./classDB.inc.php > ? y
-rw-r--r--      1 cnscn      cnscn         13709    1月 12 12:22 ./classDB.inc.php
[root@book class]# find    ./    -mtime    -1    -type f    -ok    ls -l    {} \;  
< ls ... ./classDB.inc.php > ? n
[root@book class]# =================================================
查询并交给awk去处理
[root@book class]# who    |    awk    '{print $1"\t"$2}'
cnscn     pts/0 =================================================
awk---grep---sed [root@book class]# df    -k |    awk '{print $1}' |    grep    -v    'none' |    sed    s"/\/dev\///g"
文件系统
sda2
sda1
[root@book class]# df    -k |    awk '{print $1}' |    grep    -v    'none'
文件系统
/dev/sda2
/dev/sda1


1)在/tmp中查找所有的*.h，并在这些文件中查找“SYSCALL_VECTOR"，最后打印出所有包含"SYSCALL_VECTOR"的文件名 A) find    /tmp    -name    "*.h"    | xargs    -n50    grep SYSCALL_VECTOR
B) grep    SYSCALL_VECTOR    /tmp/*.h | cut     -d':'    -f1| uniq > filename
C) find    /tmp    -name "*.h"    -exec grep "SYSCALL_VECTOR"    {}    \; -print 
2)find / -name filename -exec rm -rf {} \;
     find / -name filename -ok rm -rf {} \; 
3)比如要查找磁盘中大于3M的文件：
find . -size +3000k -exec ls -ld {} ; 
4)将find出来的东西拷到另一个地方
find *.c -exec cp '{}' /tmp ';' 如果有特殊文件，可以用cpio，也可以用这样的语法：
find dir -name filename -print | cpio -pdv newdir 
6)查找2004-11-30 16:36:37时更改过的文件
# A=`find ./ -name "*php"` |    ls -l --full-time $A 2>/dev/null | grep "2004-11-30 16:36:37

2. 无错误查找：
      find / -name access_log 2 >/dev/null
  
5. 其它：
      find / -empty 空白文件、空白文件夹、没有子目录的文件夹
      find / -false 查找系统中总是错误的文件
      find / -fstype type 找存在于指定文件系统的文件，如type为ext2
      find / -gid n 组id为n的文件
      find / -group gname 组名为gname的文件
      find / -depth n 在某层指定目录中优先查找文件内容
      find / -maxdepth levels 在某个层次目录中按递减方式查找

```

