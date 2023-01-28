

创建gitlab数据目录

```shell
mkdir -p /data/workspace/gitlab/config  #配置文件目录
mkdir -p /data/workspace/gitlab/logs    #日志目录
mkdir -p /data/workspace/gitlab/data    # 数据路径
```



docker-compose.yml

```shell
version: '3.1'
services:
  gitlab:
    image: 'gitlab/gitlab-ce:latest'
    container_name: gitlab
    restart: always
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://172.16.10.70'
        gitlab_rails['gitlab_shell_ssh_port'] = 2224
    ports:
      - '80:80'
      - '2222:22'
    volumes:
      - '/data/workspace/gitlab/config:/etc/gitlab'
      - '/data/workspace/gitlab/logs:/var/log/gitlab'
      - '/data/workspace/gitlab/data:/var/opt/gitlab'
```



```shell
 external_url 'http://172.16.10.70:8080'
```



```shell
docker-compose up -d  # 后台运行
docker-compose start  # 启动
docker-compose down   # 停止
docker-compose restart # 重启
```

需要在和docker-compose.yml文件同一目录下执行

查看日志

```shell
docker logs -f gitlab        # 通过containername 查看日志
docker logs -f 0dc984310129  # 通过containerid 查看日志
```

获取密码

```shell
docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```

默认用户是 `root`

修改密码 Overview - User - username - edit
