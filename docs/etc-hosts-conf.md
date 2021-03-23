**/etc/host.conf 文件** 
该文件指定如何解析主机名。

Linux通过解析器库来获得主机名对应的IP地址。下面是一个“/etc/host.conf”的示例： 

> order bind,hosts 
>
> multi on 
>
> ospoof on 

　　

“order bind,hosts”指定主机名查询顺序，这里规定先使用DNS来解析域名，然后再查询“/etc/hosts”文件(也可以相反)。 

“multi on”指定是否“/etc/hosts”文件中指定的主机可以有多个地址，拥有多个IP地址的主机一般称为多穴主机。 

“nospoof on”指不允许对该服务器进行IP地址欺骗。IP欺骗是一种攻击系统安全的手段，通过把IP地址伪装成别的计算机，来取得其它计算机的信任。