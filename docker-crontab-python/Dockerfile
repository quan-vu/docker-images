FROM python:3.6

# Install os crontab
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y cron

# Install python
ENV PYTHONUNBUFFERED 1
ENV WORKING_DIR /cronpy

WORKDIR /cronpy
ADD ./cronpy /cronpy

RUN pip install -U pip
RUN pip install -r /cronpy/requirements.txt

# Setup crontab
RUN cd /cronpy && \
    cp -fr crontab /etc/cron.d/cjob && \
    chmod +x cronjob.sh && \
    chmod +x start.sh && \
    touch ./cronjob.log
RUN chmod 0644 /etc/cron.d/cjob
