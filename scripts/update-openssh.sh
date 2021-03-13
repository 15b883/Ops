#!/bin/bash
# @Time   :2020/8/5 22:06
# @Auther :yanjie.li
# @Email  :381347268@qq.com
# @File   :openssh-update.sh
# @Desc   :修复openssh7.8版本以下的漏洞，升级openssh版本为8.2版本。


echo 
echo -e "\033[40;31;1m*** 安装完成后请勿立即退出当前终端(断开连接)，先新开终端进行连接测试ok后再关闭该终端 ***\033[0m"
echo 
echo "即将升级openssh"
sleep 10

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script!!"
    exit 1
fi

base_dir=`pwd`

#下载安装包：
openssh="openssh-8.2p1"
openssl="openssl-1.1.1f"


#Download the installation package
function download(){
    if [ ! -f ${openssh}.tar.gz ];then
        wget -c https://openbsd.hk/pub/OpenBSD/OpenSSH/portable/${openssh}.tar.gz
    else
        echo 'Skipping: openssh already downloaded'
    fi
    
    if [ ! -f ${openssl}.tar.gz ];then
        wget -c wget https://ftp.openssl.org/source/old/1.1.1/${openssl}.tar.gz
    else
        echo 'Skipping:  openssl already downloaded'
    fi
}


#安装依赖包
function install_relyon(){
    yum install -y telnet-server xinetd
    yum install  -y gcc gcc-c++ glibc make autoconf openssl openssl-devel pcre-devel  pam-devel
    yum install  -y pam* zlib*
    systemctl enable xinetd.service
    systemctl enable telnet.socket
    systemctl start telnet.socket
    systemctl start xinetd.service
    echo -e 'pts/0\npts/1\npts/2\npts/3'  >>/etc/securetty
    systemctl restart xinetd.service
    echo "telnet 启动成功"
    sleep 3
    echo "########################################################"
}


#备份ssh
function back_ssh(){
   mkdir /tmp/ssh_backup/
   cp /root/.ssh/authorized_keys /tmp/ssh_backup/
   cp -r /etc/ssh/ /tmp/ssh_backup/
}


#安装openssl
function install_openssl(){
    tar xfz ${base_dir}/openssl-1.1.1f.tar.gz
    echo "备份OpenSSL..."
    mv /usr/bin/openssl /usr/bin/openssl_bak
    mv /usr/include/openssl /usr/include/openssl_bak
    mv /usr/lib64/libssl.so /usr/lib64/libssl.so.bak
    echo "开始安装OpenSSL..."
    sleep 3
    cd ${base_dir}/openssl-1.1.1f
    ./config shared --prefix=/usr/local/openssl && make -j 4 && make install -j 4
    
    ln -fs /usr/local/openssl/bin/openssl /usr/bin/openssl
    ln -fs /usr/local/openssl/include/openssl /usr/include/openssl
    ln -fs /usr/local/openssl/lib/libssl.so /usr/lib64/libssl.so
    
    echo "加载动态库..."
    echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
    /sbin/ldconfig
    echo "查看确认版本。。。"
    openssl version
    echo "OpenSSL 升级完成..."
}


#安装openssh
function install_openssh(){
    echo "开始升级OPENSSH。。。。。"
    sleep 5
    cd ${base_dir}
    /usr/bin/tar -zxvf ${base_dir}/openssh-8.2p1.tar.gz
    cd ${base_dir}/openssh-8.2p1
    chown -R root.root ${base_dir}/openssh-8.2p1
    ./configure --prefix=/usr/ --sysconfdir=/etc/ssh  --with-openssl-includes=/usr/local/openssl/include \
     --with-ssl-dir=/usr/local/openssl   --with-zlib   --with-md5-passwords   --with-pam  && make -j 4 && make install -j 4
    
    [ $? -eq 0 ] && echo "openssh 升级成功..."
    cd ${base_dir}/openssh-8.2p1
    cp -a contrib/redhat/sshd.init /etc/init.d/sshd
    cp -a contrib/redhat/sshd.pam /etc/pam.d/sshd.pam
}


# 配置ssh
function config_ssh(){
    chmod +x /etc/init.d/sshd
    chkconfig --add sshd
    chmod 600 /etc/ssh/ssh_host_ed25519_key
    chmod 600 /etc/ssh/ssh_host_rsa_key
    chmod 600 /etc/ssh/ssh_host_ecdsa_key
    systemctl enable sshd
    [ $? -eq 0 ] && echo "sshd服务添加为启动项 ..."
    mv /usr/lib/systemd/system/sshd.service  /tmp/
    #允许root远程登陆
    sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
    #chkconfig sshd on
    systemctl enable sshd
    systemctl restart sshd.service
    netstat -lntp
    echo "查看SSH版本信息。。。"
    ssh -V
    sleep 3
    echo "telnet服务关闭..."
    systemctl disable xinetd.service
    systemctl stop xinetd.service
    systemctl disable telnet.socket
    systemctl stop telnet.socket
    echo "查看ssh服务"
    netstat -lntp
    echo "OpenSSH 版本升级为8.2................"
    sleep 3
}

function main(){
    download
    install_relyon
    back_ssh
    install_openssl
    install_openssh
    config_ssh
    exit
}

main