## redis
## https://download.redis.io/releases/redis-6.0.8.tar.gz
[ ! -d /opt/packages ]; mkdir -p /opt/packages
#[ ! -d /usr/local/redis ]; mkdir -p /usr/local/redis
[ ! -d /var/log/redis ]; mkdir -p /var/log/redis
cat /dev/null > /var/log/redis/redis.log

##
cd /opt/packages
wget http://download.redis.io/releases/redis-6.0.9.tar.gz
tar xf redis-6.0.9.tar.gz -C /usr/local
cd redis-6.0.9
make
make install 

## 
netstat -ntpl |grep redis