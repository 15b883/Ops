## redis
## https://download.redis.io/releases/redis-6.0.8.tar.gz
[ ! -d /opt/packages ]; mkdir -p /opt/packages
#[ ! -d /usr/local/redis ]; mkdir -p /usr/local/redis
[ ! -d /var/log/redis ]; mkdir -p /var/log/redis
cat /dev/null > /var/log/redis/redis.log

## 
yum install -y cpp binutils glibc glibc-kernheaders glibc-common glibc-devel gcc make
yum install -y centos-release-scl 
yum install -y devtoolset-9-gcc devtoolset-9-gcc-c++ devtoolset-9-binutils
##
scl enable devtoolset-9 bash
##
echo "source /opt/rh/devtoolset-9/enable" >>/etc/profile

##
cd /opt/packages
wget http://download.redis.io/releases/redis-6.0.9.tar.gz
tar xf redis-6.0.9.tar.gz -C /usr/local
cd redis-6.0.9
make
make install 

## 
netstat -ntpl |grep redis