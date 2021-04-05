# linux-awk

awk是一个强大的文本分析工具，相对于grep的查找，sed的编辑，awk在其对数据分析并生成报告时，显得尤为强大。

简单来说awk就是把文件逐行的读入，以空格为默认分隔符将每行切片，切开的部分再进行各种分析处理。



```
Examples:
	gawk '{ sum += $1 }; END { print sum }' file
	gawk -F: '{ print $1 }' /etc/passwd
```



```
NR 行号
$1 第一行 $2 第二行一次类推，但$0标识一行 
-F 指定分隔符
-F '[:#/]'   定义三个分隔符  定义多个分隔符
！ 取反
$0               正行
$1               每行第一个字段
NF               字段数量变量
NR               行号--每行的记录号，多文件记录递增
FNR              与NR类似，不过多文件记录不递增，每个文件都从1开始
\t               制表符
\n               换行符
FS               BEGIN时定义分隔符
RS               输入的记录分隔符， 默认为换行符(即文本是按一行一行输入)
~                匹配，与==相比不是精确比较
!~               不匹配，不精确比较
==               等于，必须全部相等，精确比较
!=               不等于，精确比较
&&　             逻辑与
||               逻辑或
+                匹配时表示1个或1个以上
/[0-9][0-9]+/    两个或两个以上数字
/[0-9][0-9]*/    一个或一个以上数字
FILENAME         文件名
[root@linux-node1 ~]# awk '{print FILENAME}' /etc/issue
/etc/issue
/etc/issue
/etc/issue
OFS              输出字段分隔符， 默认也是空格，可以改为制表符等
ORS              输出的记录分隔符，默认为换行符,即处理结果也是一行一行输出到屏幕

```



| **属性**    | **说明**                            |
| ----------- | ----------------------------------- |
| $0          | 当前记录（作为单个变量）            |
| $1~$n       | 当前记录的第n个字段，字段间由FS分隔 |
| FS          | 输入字段分隔符 默认是空格           |
| NF          | 当前记录中的字段个数，就是有多少列  |
| NR          | 已经读出的记录数，就是行号，从1开始 |
| RS          | 输入的记录他隔符默 认为换行符       |
| OFS         | 输出字段分隔符 默认也是空格         |
| ORS         | 输出的记录分隔符，默认为换行符      |
| ARGC        | 命令行参数个数                      |
| ARGV        | 命令行参数数组                      |
| FILENAME    | 当前输入文件的名字                  |
| IGNORECASE  | 如果为真，则进行忽略大小写的匹配    |
| ARGIND      | 当前被处理文件的ARGV标志符          |
| CONVFMT     | 数字转换格式 %.6g                   |
| ENVIRON     | UNIX环境变量                        |
| ERRNO       | UNIX系统错误消息                    |
| FIELDWIDTHS | 输入字段宽度的空白分隔字符串        |
| FNR         | 当前记录数                          |
| OFMT        | 数字的输出格式 %.6g                 |
| RSTART      | 被匹配函数匹配的字符串首            |
| RLENGTH     | 被匹配函数匹配的字符串长度          |
| SUBSEP      | \034                                |



```

3.1 常用操作
[root@linux-node1 ~]# awk '/^root/{print $0}' /etc/passwd
root:x:0:0:root:/root:/bin/bash
/^root/ 为选择表达式，$0代表是逐行
3.2 设置字段分隔符号(FS使用方法）
[root@linux-node1 ~]# awk 'BEGIN{FS=":"}/^root/{print $1,$NF}' /etc/passwd
root /bin/bash
FS为字段分隔符，可以自己设置，默认是空格，因为passwd里面是”:”分隔，所以需要修改默认分隔符。NF是字段总数，$0代表当前行记录，$1-$n是当前行，各个字段对应值。
3.3 记录条数(NR,FNR使用方法)
[root@linux-node1 ~]# awk 'BEGIN{FS=":"}{print NR,$1,$NF}' /etc/passwd  # NR得到当前记录所在行
1 root /bin/bash
2 bin /sbin/nologin
3 daemon /sbin/nologin
4 adm /sbin/nologin
5 lp /sbin/nologin
6 sync /bin/sync
7 shutdown /sbin/shutdown
。。。。。。
3.4 设置输出字段分隔符（OFS使用方法)
[root@linux-node1 ~]# awk 'BEGIN{FS=":";OFS="^^"}/^root/{print FNR,$1,$NF}' /etc/passwd  # OFS设置默认字段分隔符
1^^root^^/bin/bash
3.5 设置输出行记录分隔符(ORS使用方法）
[root@linux-node1 ~]# awk 'BEGIN{FS=":";ORS="^^"}{print FNR,$1,$NF}' /etc/passwd
1 root /bin/bash^^2 bin /sbin/nologin^^3 daemon /sbin/nologin^^4 adm /sbin/nologin^^5 lp /sbin/nologin
从上面看，ORS默认是换行符，这里修改为：”^^”，所有行之间用”^^”分隔了。
3.6 输入参数获取(ARGC ,ARGV使用）
[root@linux-node1 ~]# awk 'BEGIN{FS=":";print "ARGC="ARGC;for(k in ARGV) {print k"="ARGV[k]; }}' /etc/passwd
ARGC=2
0=awk
1=/etc/passwd
ARGC得到所有输入参数个数，ARGV获得输入参数内容，是一个数组。
[root@linux-node1 ~]# awk '{print ARGV}' /etc/issue
awk: cmd. line:1: (FILENAME=/etc/issue FNR=1) fatal: attempt to use array `ARGV' in a scalar context
[root@linux-node1 ~]# awk '{print ARGV[0]}' /etc/issue
awk
awk
awk
[root@linux-node1 ~]# awk '{print ARGV[1]}' /etc/issue
/etc/issue
/etc/issue
/etc/issue

3.7 获得传入的文件名(FILENAME使用)
[root@linux-node1 ~]# awk 'BEGIN{FS=":";print FILENAME}{print FILENAME}' /etc/passwd 
/etc/passwd 
FILENAME,$0-$N,NF 不能使用在BEGIN中，BEGIN中不能获得任何与文件记录操作的变量。
3.8 获得linux环境变量（ENVIRON使用）
[root@linux-node1 ~]# awk 'BEGIN{print ENVIRON["PATH"];}' /etc/passwd
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
ENVIRON是子典型数组，可以通过对应键值获得它的值。
3.9 输出数据格式设置：(OFMT使用）
[root@linux-node1 ~]# awk 'BEGIN{OFMT="%.3f";print 2/3,123.11111111;}' /etc/passwd
0.667 123.111
OFMT默认输出格式是：%.6g 保留六位小数，这里修改OFMT会修改默认数据输出格式。
3.10 按宽度指定分隔符（FIELDWIDTHS使用）
[root@linux-node1 ~]# echo 20170913095232 | awk 'BEGIN{FIELDWIDTHS="4 2 2 2 2 3"}{print $1"-"$2"-"$3,$4":"$5":"$6}'
2017-09-13 09:52:32
FIELDWIDTHS其格式为空格分隔的一串数字，用以对记录进行域的分隔，FIELDWIDTHS="4 2 2 2 2 2"就表示$1宽度是4，$2是2，$3是2  .... 。这个时候会忽略：FS分隔符。
3.11 RSTART RLENGTH使用
[root@linux-node1 ~]# awk 'BEGIN{start=match("this is a test",/[a-z]+$/); print start, RSTART, RLENGTH }'
11 11 4
[root@linux-node1 ~]# awk 'BEGIN{start=match("this is a test",/^[a-z]+$/); print start, RSTART, RLENGTH }'
0 0 -1
RSTART 被匹配正则表达式首位置，RLENGTH 匹配字符长度，没有找到为-1.

第4章 awk语法格式
4.1 命令行方式
awk [-F  field-separator]  'commands'  input-file(s)
其中，commands 是真正awk命令，[-F域分隔符]是可选的。 input-file(s) 是待处理的文件。
在awk中，文件的每一行中，由域分隔符分开的每一项称为一个域。通常，在不指名-F域分隔符的情况下，默认的域分隔符是空格。
4.2 shell脚本方式
将所有的awk命令插入一个文件，并使awk程序可执行，然后awk命令解释器作为脚本的首行，一遍通过键入脚本名称来调用。
相当于shell脚本首行的：#!/bin/sh
可以换成：#!/bin/awk
4.3 将所有的awk命令插入一个单独文件，然后调用
awk -f awk-script-file input-file(s)
其中，-f选项加载awk-script-file中的awk脚本，input-file(s)跟上面的是一样的。
第5章 执行过程描述
awk读入第一行内容
判断是否符合当前pattern（NR>=2)
如果匹配则执行对应的动作（｛print$0｝）
如果不匹配条件，若还有下一个pattern，则继续重复2，直到所有pattern都判断过
继续读取下一行
重复过程1)-3)，直到读取到最后一行（EOF）
5.1 命令格式
	awk指令是由模式，动作，或者模式和动作的组合组成
	模式即pattern，可以类似理解成sed的模式匹配，可以由表达式组成，也可以是两个正斜杠之间的正则表达式。比如NR＝＝＝1，这就是模式，可以把理解为一个条件
	动作即action，是由在大括号里面的一条或多条语句组成，语句之间使用分号隔开。
	awk处理的内容可以来自标准输入，一个或多个文件，或者管道
5.2 字段与记录小结
	$符号表示取某个列（区域），$1,$2,$NF
	NF(number of field)表示记录中的区域（列）数量，$NF取最后一个列（区域）
	FS（-F） field separator 字段（列）分隔符，  -F（FS）":"  <==> 'BEGIN{FS=":"}'
	RS record separator 记录分隔符（行的结束标识）
	NR number of record 行号
	选好合适的到FS（***）,RS ,OFS,ORS
	分隔符==>结束标识
	记录与区域，你就对我们所谓的行与列，有了新的认识（RS，FS）
名称	含义
record	记录，行(RS)
field	域，列(FS)


	字段（field）
	每条记录是由多个字段组成，默认情况分隔符是有空白符（即空格或制表符）
	内置变量FS记录分隔符
	每行记录的字段数保持在NF中
	字段分隔符FS是可以指定多个的
	记录（record）
	每一行内容都会成为一条记录，默认一换行符结束
	RS record separator 每个记录读入时的分隔符
	NR number of record 行号，记录的数，awk当前处理的记录的数
	ORS output record separator 输出时候的分隔符
	awk眼中的文件，从头到尾是一段连续的字符串，恰巧中间有些\n回车换行符，为了方便人类查看，就把RS的值设置为\n

5.3 案例之分隔符

[root@syaving ~]# ifconfig eth0 
eth0      Link encap:Ethernet  HWaddr 00:0C:29:18:AA:CF  
          inet addr:192.168.1.150  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:29ff:fe18:aacf/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6617 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4795 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:5497241 (5.2 MiB)  TX bytes:421960 (412.0 KiB)

[root@syaving ~]# ifconfig eth0 |awk -F "[ :]+" 'NR==2 {print $4}'
192.168.1.150
[root@syaving ~]#

5.4 案例之取文件内字符重复数
[root@syaving files]# cat test.txt 
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
[root@syaving files]# awk 'BEGIN{RS="/:"}{print $0}' test.txt 
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin

[root@syaving files]# awk 'BEGIN{RS="/"}{print $0}' test.txt 
root:x:0:0:root:
root:
bin
bash
bin:x:1:1:bin:
bin:
sbin
nologin

[root@syaving files]# awk 'BEGIN{RS="/"}{print $0}' test.txt |sort

bash
bin
bin:
bin:x:1:1:bin:
nologin
root:
root:x:0:0:root:
sbin
[root@syaving files]# awk 'BEGIN{RS="/"}{print $0}' test.txt |sort|uniq -c
      1 
      1 bash
      1 bin
      1 bin:
      1 bin:x:1:1:bin:
      1 nologin
      1 root:
      1 root:x:0:0:root:
      1 sbin
```

