# linux-grep

grep(全局正则表达式版本)允许对文本文件进行模式查找

**命令格式**

```
grep [OPTION]... PATTERN [FILE]...
```



```

-i  忽略大小写的不同，所以大小写视为相同
-n  匹配的内容在其行首显示行号
-o  只显示匹配的内容（非空行）
-E  扩展的grep，即egrep 同时过滤多个字符串，用|分割
-w 按单词搜索，相当于\b（精确匹配）
-v  反向选择，即显示没有‘搜索字符串’内容的哪一行
-r 递归搜索
--color=auto 对过滤的匹配的字符串加颜色
-B （before）除了显示匹配的一行之外，并显示该行之前的num行（包含匹配的行）
-A （after）除了显示匹配的一行之外，并显示该行之后的num行（包含匹配的行）
-C （context）除了显示匹配的一行之外，并显示该行之前后各的num行（包含匹配的行）
--color=auto 对过滤的字符串加颜色
-V 显示grep版本
+ 表示重复“一个或一个以上”前面的字符
? 表示重复“0个或者1个”前面的字符
| 表示同时过滤多个字符串
()分组过滤，后向引用
-c 只输出匹配行的计数。
-h 查询多文件时不显示文件名。
-l 查询多文件时只输出包含匹配字符的文件名。
-s 不显示不存在或无匹配文本的错误信息。
第3章 参数实例
3.1 grep 过滤变红
[root@web01 ~]# tail -1 /etc/bashrc  ##添加一下命令
alias grep='grep --color=auto'
[root@web01 ~]# source /etc/bashrc  ##source文件一下

[root@linux-node1 9_14]# cat 14_1.txt
aa
bb
[root@linux-node1 9_14]# grep --color 'aa' 14_1.txt
aa
3.2 忽略大小写
[root@linux-node1 ~]# cat 13_1.txt
aaBB
AA11
11bbcc
aa11bb
syaving
SYAVING
[root@linux-node1 ~]# grep -i "syaving" 13_1.txt   #输出所有含有syaving或SYAVING的字符串的行
syaving
SYAVING
[root@linux-node1 ~]# grep "syaving" 13_1.txt      #如何不加i的话只输出小写的syaving
syaving
3.3 反向查找（显示非匹配的行）
[root@linux-node1 ~]# cat 13_1.txt    #测试文件
aa
11
11bbcc
aa11bb
syaving
[root@linux-node1 ~]# grep -v 'syaving' 13_1.txt     #输出所有不包含syaving的行
aa
11
11bbcc
aa11bb
3.4 只显示匹配的内容（非空行）
[root@linux-node1 9_14]# grep -o 'root' /etc/passwd
root
root
root
root
3.5 多个文件查询
[root@linux-node1 ~]# cat 13_1.txt
aa
11
111111
11bbcc
aa11bb
syaving
[root@linux-node1 ~]# cat 13_2.txt
22
33
syaving
[root@linux-node1 ~]# grep "syaving" *.txt    #见文件名的匹配
13_1.txt:syaving
13_2.txt:syaving
3.6 行匹配 
[root@linux-node1 ~]# cat 13_1.txt   #测试文件
aa
11
11bbcc
aa11bb
syaving
[root@linux-node1 ~]# grep -c 'syaving' 13_1.txt   #输出文档中含有syaving字符的行数
1                                                  #grep返回数字1，意义是有1行包含字符串“syaving”。
3.7 显示匹配行和行数
[root@linux-node1 ~]# cat 13_1.txt      #测试文件
aa
11
11bbcc
aa11bb
syaving
[root@linux-node1 ~]# grep -n 'syaving' 13_1.txt    ##显示所有匹配syaving的行和行号
5:syaving
3.8 精确匹配
[root@linux-node1 ~]# cat 13_1.txt
aa
11
111111
11bbcc
aa11bb
[root@linux-node1 ~]# grep -w "11" 13_1.txt    ##精确匹配11，并不会匹配到其他包含111111或11bbcc或aa11bb
11
[root@linux-node1 ~]# grep -w "aa" 13_1.txt
aa
3.9 递归搜索
[root@linux-node1 ~]# tree
.
└── 123
    ├── 1.txt
    ├── a
    │?? └── 33.txt
    └── b

3 directories, 2 files
[root@linux-node1 ~]# grep -r 334 123/
123/a/33.txt:334
123/1.txt:334




第4章 正则实例
4.1 RE（正则表达式） 
\ 忽略正则表达式中特殊字符的原有含义 
^ 匹配正则表达式的开始行 （以。。开始的行）
$ 匹配正则表达式的结束行 （以。。结尾的行）
\< 从匹配正则表达式的行开始 （其后面的任意字符必须作为单词首部出现）
\> 到匹配正则表达式的行结束 （其前面的任意字符必须作为单词的尾部出现）
[] 单个字符；如[A] 即A符合要求 匹配指定范围内的任意单个字符
[^] 匹配指定范围外的任意单个字符
[ - ] 范围 ；如[A-Z]即A，B，C一直到Z都符合要求 
. 匹配任意单个字符 
* 所有字符，长度可以为0
\? 匹配其前面的字符1次或0次
\{m,n\} 匹配其前面的字符至少m次，至多n次
4.2 正则表达式的应用 (注意：最好把正则表达式用单引号括起来)
  grep '[239].' data.doc      #输出所有含有以2,3或9开头的，并且是两个数字的行

4.3 不匹配测试
  grep '^[^48]' data.doc      #不匹配行首是48的行
4.4 使用扩展模式匹配
  grep -E '219|216' data.doc
4.5 过滤空行和#
grep '^[^#|$]' redis.conf
第5章 字符集合
可以使用国际模式匹配的类名：
[[:upper:]]   [A-Z]
[[:lower:]]   [a-z]
[[:digit:]]   [0-9]
[[:alnum:]]   [0-9a-zA-Z]
[[:space:]]   空格或tab
[[:alpha:]]   [a-zA-Z]

(1)使用
 grep '5[[:upper:]][[:upper:]]' data.doc     #查询以5开头以两个大写字母结尾的行

```

