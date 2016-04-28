FROM phusion/baseimage:0.9.16
MAINTAINER Chevdor <chevdor@gmail.com>
LABEL version="0.1.2"

LABEL NRSVersion="3.0.7"

ADD https://codeload.github.com/Tosch110/SuperNET-Lite-3/zip/3.0.7/SuperNET-Lite-3-3.0.7.zip /


RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer wget unzip joe && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  cd / && \
  wget https://bitbucket.org/longzai1988/supernet/downloads/supernet-1.5.12.1.zip && \ 
  unzip supernet*.zip && \
  mv supernet-1.5.12.1 supernet && \
  rm *.zip && \
  cd /supernet && \
  chmod a+x run.sh && \
  rm -Rf *.exe src changelogs

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

VOLUME /supernet

ENV NXTNET test       
# when running the container, you can override that using -e "NXTNET=main"

COPY ./nxt-main.properties /supernet/conf/
COPY ./nxt-test.properties /supernet/conf/
COPY ./start-supernet.sh /supernet/

CMD ["/supernet/start-supernet.sh", "/bin/bash"] 