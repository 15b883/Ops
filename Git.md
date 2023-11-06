

## 清理本地缓存

```
git rm -r --cached .
```



## **设置用户信息**

现在你已经可以通过 SSH 链接到 GitHub 了，还有一些个人信息需要完善的。

Git 会根据用户的名字和邮箱来记录提交。GitHub 也是用这些信息来做权限的处理，输入下面的代码进行个人信息的设置，把名称和邮箱替换成你自己的，名字必须是你的真名，而不是GitHub的昵称。

 ```shell
 ## 全局配置
 git config --global user.name "username"     //全局配置 用户名
 git config --global user.email "useremail"   //全局配置 填写自己的邮箱
 ## 单一配置
 git config user.name "username"                
 git config user.email "useremail"
 ```

## **测试SSH Key 配置成功**

本机已成功连接到 GitHub。

报错

ssh -T git@github.com命令，检查当前配置的SSH对应的git账号

`ssh-add -K ~/.ssh/id_rsa` (id_rsa对应目标账户的私钥)命令，制定目标Git账号                      

```
  keys ssh -T git@GitHub.com
git@github.com: Permission denied (publickey).
➜  keys
➜  keys ssh-add -K 15b883_rsa
Identity added: 15b883_rsa (15b883@15b883.local)
➜  keys ssh -T git@GitHub.com
Hi 15b883! You've successfully authenticated, but GitHub does not provide shell access.
```



## 单独提交某个目录的文件

```shell
进入你要操作的目录，跟Linux环境一样
git status ./           查看这个文件夹下的文件状态，会列出有哪些没有加入追踪，哪些没有commit
git add ./*             把这个文件下的所有应该加入追踪的，加入到暂存区
git commit -m "日志描述" ./           把这个文件夹下可以commit的，都commit到本地库
git push                push到远程库
```

## 忽略某个文件或目录不提交

在目录内创建.gitignore 添加文件或目录信息 如下：

```shell
vim .gitignore 
#ignore .metadata
.metadata
.gitignore
.git
#ignore obj and lib file
*.[oa]
.DS_Store
node_modules
venv
_api/local_settings.py
```

## git命令

```
git init    创建仓库
git clone   克隆一个远程仓库
git config  配置仓库
git add     添加修改到暂存区
git commit  提交修改到版本库
git log     查看提交历史
git status  查看文件状态
git diff    修改差异比较
git show    查看某个提交信息
```

## 文件管理

```
git add .           添加工作区所有文件
git commit -a       一次性提交
git commit --amend  修改最后一次提交
git rm file          从工作目录和暂存区中删除文件
git rm --cached     从暂存区中删除，工作区保留
git reset SHA       回退版本到工作目录
git reset --soft    回退版本到暂存区
git reset --hard    回退版本，修改丢弃
git mv              文件重命名
git checkout file   撤销工作区修改
git reset HEAD file 撤销暂存区修改
git diff --cached   比较暂存区和版本库差异
git diff SHA1 SHA2  比较两个版本差异
git gc              压缩仓库
```

## 历史记录

```
git log --pretty=oneline  单行显示
git log -p                显示每次提交具体的修改
gitk                      图形化显示提交历史
git blame                 查看指定文件的提交历史
git grep                  提交查找
git revert                反转提交
git reflog                查看操作记录
```

## 分支管理

```
git branch            查看分支
git branch develop   创建分支
git checkout          分支检出、切换分支

git push --set-upstream origin old  ##创建好分支了，还要把创建的分支提交一遍

git branch -d         删除分支
git branch -m         分支重命名
git merge             分支合并
////
将dev分支合并到master分支
首先切换到master分支上
git  checkout master如果是多人开发的话 需要把远程master上的代码pull下来
git pull origin master
如果是自己一个开发就没有必要了，为了保险期间还是pull
然后我们把dev分支的代码合并到master上
git  merge dev
////
git cherry-pick       挑拣分支
git rebase            分支衍合
git stash             分支修改储藏
git stash apply(pop)  恢复分支修改储藏
git fsck              查看悬空commit对象

## 确认提交当前分支为默认分支
git config –global push.default current
## 分支重命名
1、本地分支重命名
 git branch -m oldName  newName
2、将重命名后的分支推送到远程
git push origin newName
3、删除远程的旧分支
git push --delete origin oldName
显示如下，说明删除成功
To http://11.11.11.11/demo/demo.git
 - [deleted]           oleName
```

## 标签管理

```
git tag v1.0                   添加标签
git tag                        查看标签
git tag -d                     删除标签
git push origin v1.0           推送某个标签
git push origin --tags         推送所有标签
git push origin refs/tags/v1.0 删除远程标签


# 创建tag
git tag -a V1.2 -m 'release 1.2'
# 查看tag
git tag
git show V1.2  #要显示附注信息,我们需要用 show 指令来查看
git push origin --tags #但是目前这个标签仅仅是提交到了本地git仓库.如何同步到远程代码库
如果刚刚同步上去,你缺发现一个致命bug ,需要重新打版本,现在还为时不晚.

git tag -d V1.2
到这一步我们只是删除了本地 V1.2的版本,可是线上V1.2的版本还是存在,如何办?这时我们可以推送的空的同名版本到线下,达到删除线上版本的目标:

git push origin :refs/tags/V1.2
如何获取远程版本?

git fetch origin tag V1.2
```

## 远程仓库

```
git remote add     添加远程仓库git
git fetch          拉取远程更新到本地仓库
git pull           拉取远程更新并合并到本地仓库
git push           推送本地修改到远程仓库
git remote -v      查看远程仓库信息
git remote rm      删除远程仓库
git remote rename  远程仓库重命名
git branch b1 origin/b1 跟踪远程分支
git push origin :b1     删除远程分支

git remote add origin git@github.com:15b883/test.git
git push -u origin master
```

## 版本回滚

```
## 显示提交的log
git log -3     ##显示最近的3次提交
## 回滚到指定的版本
git reset --hard e377f60e28c8b84158
## 强制提交
git push -f origin main
```





## 脚本

```
dates=`date "+%Y-%m-%d"` #日期
times=`date "+%H:%M:%S"` #时间
logs=/www/gitTools/logs/$dates.log #日志
echo "==========="$times"===========" >> $logs

root="/www" #程序根目录
list=$(ls -F $root | grep '/$') #获取网站列表
for dirname in $list
do
    path=$root"/"$dirname #网站绝对路径;
    cd $path #进入网站目录
    isGit=$(ls -a|grep -x .git | wc -l) #判断是否有仓库
    if [ $isGit -gt 0 ];then
        isAdd=$(git status | grep "git add" | wc -l) #判断是否需要提交
        if [ $isAdd -gt 0 ];then
            git add .
            git commit -m 自动提交_$dates_$times
            git push origin master
            echo "+提交完成" $path >> $logs
        else
            echo "-没有更改" $path >> $logs
        fi
    else
        echo "x没有仓库" $path >> $logs
    fi
    
done

echo "">>$logs #隔行
```

```shell
type
用于表示commit的类别，允许用下面8个标识
ftr/（feat）:新功能(feature)无ftr历史原因的，请使用feat
fix:修补bug
docs:文档(documentation)
style:格式(不影响代码运行的变动)
refactor:重构(即不是新增功能，也不是修改bug的代码变动)
test:增加测试
chore:构建过程或辅助工具的变动
conflict:解决冲突

第一种方法:
.gitignore中已经标明忽略的文件目录下的文件，git push的时候还会出现在push的目录中，或者用git status查看状态，想要忽略的文件还是显示被追踪状态。
原因是因为在git忽略目录中，新建的文件在git中会有缓存，如果某些文件已经被纳入了版本管理中，就算是在.gitignore中已经声明了忽略路径也是不起作用的，
这时候我们就应该先把本地缓存删除，然后再进行git的提交，这样就不会出现忽略的文件了。
  
解决方法: git清除本地缓存（改变成未track状态），然后再提交:
[root@kevin ~]# git rm -r --cached .
[root@kevin ~]# git add .
[root@kevin ~]# git commit -m 'update .gitignore'
[root@kevin ~]# git push -u origin master
 
需要特别注意的是：
1）.gitignore只能忽略那些原来没有被track的文件，如果某些文件已经被纳入了版本管理中，则修改.gitignore是无效的。
2）想要.gitignore起作用，必须要在这些文件不在暂存区中才可以，.gitignore文件只是忽略没有被staged(cached)文件，
   对于已经被staged文件，加入ignore文件时一定要先从staged移除，才可以忽略。
   
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch lab1-create-ec2-instance/.terraform/providers/registry.terraform.io/hashicorp/aws/3.33.0/darwin_amd64/terraform-provider-aws_v3.33.0_x5"  --prune-empty --tag-name-filter cat -- --all

```

## 本地设置多个git账号

```shell
# gitee
Host git@gitee.com      //别名，用这个以后可以直接用常规的SSH下载，这个好处以后你会知道的
    HostName gitee.com  //网站域名
    User xxx            //网站用户名
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_gitee    //指定使用的密钥文件
    //Port 443          //有的网站不能走22端口，所以必要时需要手动指定端口

# github
Host git@github.com
    HostName github.com
    User zhangsan
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_github

# bitbucket
Host git@bitbucket.org
    HostName bitbucket.org
    User lisi
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_bitbucket
```

## 如何保持github上fork的项目与原项目同步

```
# 查看本地 Fork 仓库的远程信息
➜  config git:(develop) git remote -v   
origin	git@github.com:zhangsan/config.git (fetch)
origin	git@github.com:zhangsan/config.git (push)
➜  config git:(develop)
➜  config git:(develop)
# 添加远程源仓库
➜  config git:(develop) git remote add upstream git@github.com:PaaS/config.git
# 结果展示
➜  config git:(develop) git fetch upstream
remote: Enumerating objects: 466, done.
remote: Counting objects: 100% (273/273), done.
remote: Compressing objects: 100% (37/37), done.
remote: Total 466 (delta 216), reused 256 (delta 211), pack-reused 193
Receiving objects: 100% (466/466), 101.98 KiB | 274.00 KiB/s, done.
Resolving deltas: 100% (244/244), completed with 30 local objects.
From github.com:PaaS/config
 * [new branch]      develop           -> upstream/develop
 * [new branch]      dsanthosh-patch-1 -> upstream/dsanthosh-patch-1
 * [new branch]      dsanthosh-patch-2 -> upstream/dsanthosh-patch-2
 * [new branch]      master            -> upstream/master
 * [new branch]      release           -> upstream/release
 * [new branch]      v.2.8.22-hot      -> upstream/v.2.8.22-hot
 * [new branch]      v2.8.23-hot       -> upstream/v2.8.23-hot
 * [new branch]      v2.8.23-hotfix    -> upstream/v2.8.23-hotfix
 * [new tag]         v2.8.22-hot       -> v2.8.22-hot
 * [new tag]         v2.8.23-hot       -> v2.8.23-hot
 * [new tag]         v2.8.23-hotfix    -> v2.8.23-hotfix
 * [new tag]         v3.0.2            -> v3.0.2
 * [new tag]         v2.8.26           -> v2.8.26
 * [new tag]         v2.8.27           -> v2.8.27
 * [new tag]         v2.8.28           -> v2.8.28
 * [new tag]         v3.0.0            -> v3.0.0
 * [new tag]         v3.0.1            -> v3.0.1
# 合并源仓库的更新内容到本地仓库 
➜  config git:(develop) git merge upstream/develop
```



## git标准

```shell
原则
代码的commit遵循的原则：
一个commit 只做一件事
一个MR不能引入过多的commits,导致很难甚至无法完成review
最小化原则体现：
尽量不同时修改多个文件
尽量不同时修改多个逻辑上游划分的模块
不破坏已有逻辑
不修改无关的部分
一个大的变更尽量拆解成多个更独立的MR
要求
commit message 可以使用英文，也可以使用中文，但应尽可能描述清楚 commit 所做的事情。如：type: subject
commit 中type为：feat(实现功能)，fix(bug修复)， docs(完善文档)，style(格式化代码)， refactor(仅重构不改动功能)， test(增加，重构，修复测试，不改动功能代码) ，chore(其他小的修复)。subject 需要简短的描述做了件什么事情。
可以使用 Commitizen 等工具进一步规范 commit message 格式
MR 由两部分组成：MR 说明，以及一系列的 commit。
通常 MR 的标题部分应当包含对应的 Issue ID（例如 XXXXX-1234），以及简短的描述做了件什么事情。如：:
Code Review
什么是Code Review
代码评审(Code Review)是指在功能开发过程中，邀请原作者之外的开发者(审阅人)来对功能代码 进行评审的步骤。其目的是为了在代码合并入主线之前确保其质量，避免对主线代码的质量造成负面的影响。
实际开发中，我们通常都是在各自开发分支进行开发，那么功能开发完成之后，或修复bug之后，就需要除了自己之外的其他人进行code review。从而提高代码的质量以及避免合并到主线上之后对主线代码造成影响。所以code review 最直接的目的就是：代码长期的可用性与可维护性
Code Review 流程
流程：
开发者从master分支切换开发分支进行功能开发
开发者将代码提交到新的分支，并提交MR，开发者需要自己解决冲突rebase master
开发者选择不少于一个(推荐两个)审阅人，请求其帮忙 review 代码;通常直接在 MR 下 at 审阅人请求 review 或将 MR assign 给相应的审阅人即可
审阅人认为存在问题，告知开发者，由开发者进一步完善;推荐以评论的方式进行记录，即使当面沟通也需要以评论的方式记录一下讨论结果;另外，MR 下的问题讨论应当由审阅人来 resolve，在审阅人明确表示问题得到解决之前，开发者应当避免随意关闭审阅人提出的问题
审阅人认为没有问题，Approve MR;或直接在 MR 下评论 “reviewed by @someone”、“LGTM” 等
在至少有一位审阅人完成评审的情况下，由模块负责人将 MR 合入主线，如存在冲突则需要开发者先将分支重新 rebase 主线
Git 团队协作中常用术语:
WIP   Work in progress, do not merge yet. // 开发中
LGTM Looks good to me. // Riview 完别人的 PR ，没有问题
PTAL Please take a look. // 帮我看下，一般都是请别人 review 自己的 PR
CC Carbon copy // 一般代表抄送别人的意思
RFC  —  request for comments. // 我觉得这个想法很好, 我们来一起讨论下
IIRC  —  if I recall correctly. // 如果我没记错
ACK  —  acknowledgement. // 我确认了或者我接受了,我承认了
NACK/NAK — negative acknowledgement. // 我不同意
如何提交一个MR
定方案–>写代码–>自测–>提 MR
MR所包含的内容：
代码的改动： 实现功能/修复缺陷/补充测试….
MR自身的描述信息：帮助审阅人理解上述改动
commit历史：commit历史应该是被整理之后的
关于commit历史： 通常我们在开发过程中的commit历史是会比较糟糕的，可能也commit message 也会不规范，所以我们在提交mr之前就需要对我们的commit历史进行整理，如：
合并一些无用的commit历史
更改不规范的commit message
…..
注：对于没有任何描述的MR审阅人可以直接拒绝审阅
注：永远做自己MR的第一个审阅人
对于MR代码质量要求
如果认为一个 MR 在被接受那一刻的得分为 90~100 分的话，提交 MR 时分数不应低于 80 分
将 MR 完成到 80 分是开发者的责任，在达成之前，审阅者没有义务帮助开发者审阅并完善 MR
低于 80 分的 MR 认为完成度过低，应当被打上 WIP 标记
当审阅人认为完成度过低时，可以直接将 MR 标记为 WIP 并拒绝审阅(甚至可以不解释)
当代码质量出现(不限于)以下情况时，可以认为完成度过低：
代码风格/格式不符合编码规范
缺少必要的(单元)测试代码
破坏兼容性且未标注或说明(包含改变了特定接口的行为但未更新注释)
明显未经过自测便提交
存在较多(3 个及以上)低级逻辑错误(偏主观，无明确标准)
…..
```

## CODEOWNERS

CODEOWNERS的使用方法如下:

- CODEOWNERS是一个放在仓库里的文件,用于定义谁负责审查对特定文件/目录的更改。它使用与 .gitignore 相同的模式语法。

- 每行是一个文件模式,后跟一个或多个使用标准 @提及格式的 GitHub 用户名或团队名称。

- CODEOWNERS文件使用与 .gitignore 相同的模式语法来匹配文件路径。模式匹配是逐行进行的。

- 在仓库的根目录、docs/ 或 .github/ 目录中放置 CODEOWNERS 文件。

- 当有人打开一个拉取请求,修改了拥有代码所有权的代码时,这些用户将自动被请求为审阅者。

- 当有人打开一个拉取请求,修改他们拥有的代码时,代码所有者将自动被请求审阅。

- 如果一个文件有多个所有者,其中只需要一个人批准 PR。首先匹配的模式优先。

- 使用通配符(*)来匹配多个文件/目录。例如 `*.js` 匹配所有 js 文件。 

- 使用 `*` @用户名来为所有没有更具体匹配的内容设置默认用户。

- 以 `#` 开头的是注释。`#` 之后的内容会被忽略。

总之,CODEOWNERS 允许您在仓库中定义责任区域,以自动请求合适的人进行审阅。遵循模式语法,放在根目录或 .github 文件夹中,并使用通配符进行广泛匹配。

这里提供几个CODEOWNERS文件的使用案例:

1. 为所有JS文件指定代码所有者

```
*.js @octocat
```

这会将@octocat设置为所有js文件代码的所有者。

2. 为docs文件夹中的文件指定代码所有者

```  
docs/* @johnny
```

这会将@johnny设置为docs文件夹中所有文件的代码所有者。

3. 为特定文件指定代码所有者

```
*.go @gopher
server.js @nodelover
```

这会将@gopher设置为所有go文件的代码所有者,将@nodelover设置为server.js的代码所有者。

4. 设置一个默认代码所有者

```
* @defowner
```

这会将@defowner设置为仓库中其他所有文件的默认代码所有者。

5. 忽略注释

```
# This is a comment
*.py @pythonista
```

以#开头的这一行会被忽略,实际上只有*.py @pythonista这一行有效。

6. 为目录设置代码所有者

```
/src/ @src-owner
/tests/ @test-owner
```

这为src目录设置@src-owner为代码所有者,为tests目录设置@test-owner为代码所有者。
