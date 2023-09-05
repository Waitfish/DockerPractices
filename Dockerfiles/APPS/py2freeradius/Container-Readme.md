# 容器使用介绍

> 该容器可实现定时解析 squid 日志，并将消息推送到 FreeRadius 服务器，详细的脚本使用说明见本目录下的`README.md`文件。

## dockerfile

```yaml
FROM python:alpine3.18
RUN  pip install pyrad hurry.filesize 
ADD ./ /app
ADD crontab /etc/cron.d/my-cron-file
RUN chmod 0644 /etc/cron.d/my-cron-file && crontab /etc/cron.d/my-cron-file
ENV $SQUID_LOG_PATH=/var/log/squid/access.log 
ENV $FREERADIUS_SERVER=test_server_ip_or_hostname
ENV $FREERADIUS_PASSWORD=test_password 
ENTRYPOINT ["crond", "-f"]
```

## 默认的contab 文件

```bash
*/5 * * * * python /app/squid2radius-py3.py $SQUID_LOG_PATH $FREERADIUS_SERVER $FREERADIUS_PASSWORD 2>&1; cat /dev/null>$SQUID_LOG_PATH 2>&1
```

如果要改变脚本执行的频率，使用自定义的文件覆盖该文件即可。

```yaml
...
   volumes:
     - /xx/xx.conf:/etc/cron.d/:/etc/cron.d/my-cron-file
...
```

## 环境变量

- SQUID_LOG_PATH:squid 访问日志路径，默认为/var/log/squid/acesss.log
- FREERADIUS_SERVER:FreeRadius 的服务器地址
- FREERADIUS_PASSWORD:Freeradius 的密码

## docker-compose.yml

```yaml
services:
  squid:
    image: ubuntu/squid:5.2-22.04_beta
    environment:
      - TZ=UTC
    volumes:
      - ./squid/squid.conf:/etc/squid/squid.conf
      - ./squid/radius.conf:/etc/squid/radius.conf
      - 'LogsData:/var/log/squid'
      - 'SquidCacheData:/var/spool/squid'
    restart: unless-stopped

  py2radius:
    image: qcpm1983/py2freeradius:main 
    volumes:
      - 'LogsData"/var/log/squid'
    restart: unless-stopped
    environment:
      - TZ=UTC
      - SQUID_LOG_PATH=/var/log/squid/access.log
      - FREERADIUS_SERVER=X.X.X.X
      - FREERADIUS_PASSWORD=XXXX
volumes:
  LogsData:
    driver: local
  SquidCacheData:
    driver: local

```
