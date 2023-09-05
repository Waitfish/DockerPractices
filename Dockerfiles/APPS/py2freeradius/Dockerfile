FROM  python:alpine3.18
RUN  pip install pyrad hurry.filesize 
ADD ./ /app
ADD crontab /etc/cron.d/my-cron-file
RUN chmod 0644 /etc/cron.d/my-cron-file && crontab /etc/cron.d/my-cron-file
ENTRYPOINT ["crond", "-f"]