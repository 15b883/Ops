## redis
## https://download.redis.io/releases/redis-6.0.8.tar.gz
[ ! -d /opt/packages ]; mkdir -p /opt/packages
[ ! -d /usr/local/redis ]; mkdir -p /usr/local/redis
echo -n > /var/logs/redis/redis.log

##
cd /opt/packages
wget http://download.redis.io/releases/redis-6.0.9.tar.gz
tar xf redis-6.0.9.tar.gz
cd redis-6.0.9
make
make install PREFIX=/usr/local/redis
##
vim /data/server/redis/redis.conf
daemonize  yes
logfile "/var/logs/redis/redis.log" 
#save 900 1
#save 300 10
#save 60 10000
/data/server/redis/src/redis-server

