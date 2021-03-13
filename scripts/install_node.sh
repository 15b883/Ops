## node npm
## https://nodejs.org/en/download/
##
[ ! -d /opt/packages ]; mkdir -p /opt/packages
[ ! -d /usr/local/node ]; mkdir -p /usr/local/node
##
cd /opt/packages
wget https://nodejs.org/dist/v14.15.1/node-v14.15.1-linux-x64.tar.xz
tar xf node-v14.15.1-linux-x64.tar.xz 
mv /opt/packages/node-v14.15.1-linux-x64/* /usr/local/node/
echo "export PATH=/usr/local/node/bin:$PATH" >> /etc/profile
source /etc/profile
## 使用淘宝镜像源，安装速度会快一些
npm config set registry https://registry.npm.taobao.org
## 安装依赖
#npm install -g
## 安装pm2
npm install -g pm2