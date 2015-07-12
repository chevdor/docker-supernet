FROM nginx:latest
MAINTAINER Chevdor <chevdor@gmail.com>
LABEL version="0.1.2"
LABEL NRSVersion="2.0.5-beta"

ADD https://bitbucket.org/longzai1988/supernetv1-lite/downloads/supernet-lite-2.0.5-beta.zip /

RUN \
  apt-get update && \
  apt-get install -y unzip \
    joe \
    # wget \
    && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  cd / && \
  unzip supernet*.zip && \
  mv supernet-lite-2.0.5-beta supernet && \
  rm *.zip && \
  cd /supernet

# RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
ADD nginx.conf /etc/nginx/nginx.conf

