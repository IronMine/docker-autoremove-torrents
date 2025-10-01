FROM python:3.13-slim

WORKDIR /app

RUN pip install autoremove-torrents

RUN apt update \
&& apt install cron -y -q \
&& apt clean

ADD cron.sh /usr/bin/cron.sh
RUN chmod +x /usr/bin/cron.sh

RUN touch /var/log/autoremove-torrents.log

COPY config.example.yml config.yml

ENV OPTS '-c /app/config.yml'
ENV CRON '*/5 * * * *'

ENTRYPOINT ["/bin/sh", "/usr/bin/cron.sh"]
