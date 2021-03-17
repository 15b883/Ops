# Linux 库

Linux系统和其他操作系统一样，都是模块化的设计，也就是说功能互相依靠，有些功能需要一些其他功能来支撑，这样可以提高代码的可重用性：

大部分依赖包都是一些库文件，有动态库也有静态库，一个程序的依赖包如果没有安装，只安装了这个程序本身是不能使用

Linux系统中：
1.静态库的扩展名为.a；
2.动态库的扩展名为.so；

> 你可以理解为似windows的库文件，譬如DLL
>
> 比如我要装某个软件，这个软件又依赖于某个开发包，这个开发包包含这个软件所要运行
>
> 的环境文件，这就是依赖关系。 
>
> 再举个例子，比如我要去XX看视频一样。我就需要需要装flash。因为XX的播放器是基于flash开发的。



库是一种可执行代码的二进制格式，能够被载入到内存中执行，库分静态库和动态库两种：

静态库：

这类库的名字一般是libxxx.a，xxx为库的名字。利用静态函数库编译成的文件比较大，因为整个函数库的所有数据都会被整合进目标代码中，他的优点就显而易见了，即编译后的执行程序不需要外部的函数库支持，因为所有使用的函数都已经被编译进去了。当然这也会成为他的缺点，因为如果静态函数库改变了，那么你的程序必须重新编译。

动态库：

这类库的名字一般是libxxx.M.N.so，同样的xxx为库的名字，M是库的主版本号，N是库的副版本号。当然也可以不要版本号，但名字必须有。相对于静态函数库，动态函数库在编译的时候并没有被编译进目标代码中，你的程序执行到相关函数时才调用该函数库里的相应函数，因此动态函数库所产生的可执行文件比较小。由于函数库没有被整合进你的程序，而是程序运行时动态的申请并调用，所以程序的运行环境中必须提供相应的库。动态函数库的改变并不影响你的程序，所以动态函数库的升级比较方便。linux系统有几个重要的目录存放相应的函数库，如/lib /usr/lib。

当要使用静态的程序库时，连接器会找出程序所需的函数，然后将它们拷贝到执行文件，由于这种拷贝是完整的，所以一旦连接成功，静态程序库也就不再需要了。然而，对动态库而言，就不是这样。动态库会在执行程序内留下一个标记指明当程序执行时，首先必须载入这个库。由于动态库节省空间，linux下进行连接的缺省操作是首先连接动态库，也就是说，如果同时存在静态和动态库，不特别指定的话，将与动态库相连接。



centos

```shell
yum install gcc* automake zlib-devel libjpeg-devel giflib-devel freetype-devel
yum -y install make gcc-c++ cmake bison-devel ncurses-devel
```

ubuntu

```shell
sudo apt-get install zlib1g-dev libbz2-dev libssl-dev libncurses5-dev libsqlite3-dev libreadline-dev tk-dev libgdbm-dev libdb-dev libpcap-dev xz-utils libexpat-dev
```



gcc make wget tar

> gcc make zlib wget tar
>
> 依赖库GMP、MPFR、MPC

1、本地挂载到某个目录 

```
mount /xxx.iso /opt #注意挂载的目录是空目录
```

2、进行挂载后的目录

3、找到packages目录

4、找到相应的安装包进行安装

linux, configure --prefix=/ 的作用是：编译的bai时候用来指定程du序存放路径 。

1、不指定prefix

- 可执行文件dao默认放在/usr /local/bin
- 库文件默认放在/usr/local/lib
- 配置文件默认放在/usr/local/etc
- 其它的资源文件放在/usr /local/share

2、指定prefix，直接删掉一个文件夹就够了

## make 

```
wget http://ftp.gnu.org/gnu/make/make-4.2.tar.gz
tar -zxvf make-4.2.tar.gz
cd make-4.2
./configure
make
make install
ln -s -f /usr/local/bin/make  /usr/bin/make
```



## zlib

http://www.zlib.net

http://www.zlib.net/zlib-1.2.11.tar.gz

http://www.zlib.net/zlib-1.2.11.tar.gz

configure: error: *** zlib.h missing – please install first or check config.log

```
wget http://www.zlib.net/zlib-1.2.8.tar.gz
tar -xvzf zlib-1.2.8.tar.gz
cd zlib-1.2.8.tar.gz
./configure
make
make instal
```



## gcc

[ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/](ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/)

[ftp://gcc.gnu.org/pub/gcc/infrastructure/](ftp://gcc.gnu.org/pub/gcc/infrastructure/)

```
cd /opt
wget http://ftp.gnu.org/gnu/gcc/gcc-5.3.0/gcc-5.3.0.tar.gz
tar -xvf gcc-5.3.0.tar.gz
mkdir /usr/local/gcc-5.3.0/
./opt/gcc-5.3.0/configure -prefix=/usr/local/gcc-5.3.0
make
make install

##
LD_LIBRARY_PATH=:/usr/local/mpc-0.8.1/lib:/usr/local/gmp-4.3.2/lib:/usr/local/mpfr-2.4.2/lib:/usr/local/gcc-5.3.0/lib:/usr/local/gcc-5.3.0/lib64

```

## 依赖库GMP、MPFR、MPC

```
⑴ 安装GMP4.3.2
cd /opt
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/gmp-4.3.2.tar.bz2
tar -xvf gmp-4.3.2.tar.bz2
cd /opt/gmp-4.3.2
mkdir /usr/local/gmp-4.3.2
./configure --prefix=/usr/local/gmp-4.3.2
make
make install


⑵ 安装MPFR2.4.2
#进入下载目录
cd /opt
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpfr-2.4.2.tar.bz2
tar -xvf mpfr-2.4.2.tar.bz2
cd /opt/mpfr-2.4.2
mkdir /usr/local/mpfr-2.4.2
./configure --prefix=/usr/local/mpfr-2.4.2 --with-gmp=/usr/local/gmp-4.3.2
make
make install

⑶ 安装MPC0.8.1
cd /opt
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpc-0.8.1.tar.gz
tar -xvf mpc-0.8.1.tar.gz
cd /opt/mpc-0.8.1
mkdir /usr/local/mpc-0.8.1
./configure --prefix=/usr/local/mpc-0.8.1 --with-gmp=/usr/local/gmp-4.3.2 --with-mpfr=/usr/local/mpfr-2.4.2
make
make install
```

