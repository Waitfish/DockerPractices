FROM bitnami/python:3.9.18
RUN  pip install pyrad hurry.filesize && apt update -y &&apt install cron -y && rm -rf /var/cache/apk/* 
ADD ./ /app
ADD crontab /etc/cron.d/my-cron-file
RUN chmod 0644 /etc/cron.d/my-cron-file
RUN crontab /etc/cron.d/my-cron-file
ENTRYPOINT ["cron", "-f"]