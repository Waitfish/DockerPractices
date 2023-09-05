FROM python:alpine3.18
RUN  pip install pyrad hurry.filesize 
ADD ./ /app
ADD crontab /etc/cron.d/my-cron-file
RUN chmod 0644 /etc/cron.d/my-cron-file && crontab /etc/cron.d/my-cron-file
ENV $SQUID_LOG_PATH=/var/log/squid/access.log 
ENV $FREERADIUS_SERVER=test_server_ip_or_hostname
ENV $FREERADIUS_PASSWORD=test_password 
ENTRYPOINT ["crond", "-f"]