## Jdk

[Java SE Development Kit 8 - Downloads](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

下载安装包`jdk-8u271-linux-x64.tar.gz` 并解压到`/usr/local/`并重名命名为**jdk**文件夹

```shell
## vim /etc/profile
export JAVA_HOME=/usr/local/jdk
export JRE_HOME=${JAVA_HOME}/jre  
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib  
export PATH=${JAVA_HOME}/bin:$PATH
##
source /etc/profile
```

查看Jdk版本

```shell
[root@localhost ~]# java -version
java version "1.8.0_271"
Java(TM) SE Runtime Environment (build 1.8.0_271-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.271-b09, mixed mode)
```

## Maven

http://maven.apache.org/download.cgi

下载安装包`apache-maven-3.6.3-bin.tar.gz`并解压到`/usr/local/`并重名命名为**maven**文件夹

```shell
## vim /etc/profile
export MAVEN_HOME=/usr/local/maven
export PATH=${PATH}:${MAVEN_HOME}/bin
## 
source /etc/profile
```

查看maven版本

```shell
[root@localhost ~]# mvn -v
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: /usr/local/maven
Java version: 1.8.0_271, vendor: Oracle Corporation, runtime: /usr/local/jdk/jre
Default locale: zh_CN, platform encoding: UTF-8
OS name: "linux", version: "5.9.8-1.el7.elrepo.x86_64", arch: "amd64", family: "unix"
```

## maven仓库阿里云加速



```
[root@pipeline-server conf]# pwd
/usr/local/maven/conf
[root@pipeline-server conf]# ls
logging  settings.xml  toolchains.xml
[root@pipeline-server conf]#
##

<mirror>
  <id>aliyunmaven</id>
  <mirrorOf>*</mirrorOf>
  <name>阿里云公共仓库</name>
  <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```



```shell
  <!-- 全局JDK1.8配置 -->
        <profile>
            <id>jdk1.8</id>
            <activation>
                <activeByDefault>true</activeByDefault>
                <jdk>1.8</jdk>
            </activation>
            <properties>
                <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
                <maven.compiler.source>1.8</maven.compiler.source>
                <maven.compiler.target>1.8</maven.compiler.target>
                <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
            </properties>
        </profile>
```





## 修改默认仓库位置

打开maven目录 -> conf -> setting.xml

```shell
# 添加仓库位置配置
<localRepository>/data/repository</localRepository>
```

## 执行命令

```shell
mvn compile
mvn exec:java -Dexec.mainClass="Demo"
mvn package -Dmaven.test.skip=true
mvn package -Pdev -Dmaven.test.skip=true
# 命令描述
mvn clean 清理项⽬⽣产的临时⽂件,⼀般是模块下的target⽬录
mvn compile 编译源代码，⼀般编译模块下的src/main/java⽬录
mvn package 项⽬打包⼯具,会在模块下的target⽬录⽣成jar或war等⽂件
mvn test 测试命令,或执⾏src/test/java/下junit的测试⽤例.
mvn –version 显示版本信息
mvn install 将打包的jar/war⽂件复制到你的本地仓库中,供其他模块使⽤
mvn deploy 将打包的⽂件发布到远程参考,提供其他⼈员进⾏下载依赖
mvn site ⽣成项⽬相关信息的⽹站
mvn eclipse:eclipse 将项⽬转化为Eclipse项⽬
mvn dependency:tree 打印出项⽬的整个依赖树
mvn archetype:generate 创建Maven的普通java项⽬
mvn tomcat7:run 在tomcat容器中运⾏web应⽤
mvn jetty:run 调⽤Jetty 插件的Run ⽬标在Jetty Servlet 容器中启动web 应⽤
```
