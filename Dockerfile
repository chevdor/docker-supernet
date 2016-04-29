FROM jeanblanchard/java:jre-8
MAINTAINER Chevdor <chevdor@gmail.com>
LABEL version="3.0.7"

LABEL NRSVersion="3.0.7"

RUN \
  apk update && \
  apk add wget libstdc++ && \
  cd / && \
  wget --no-check-certificate https://github.com/Tosch110/SuperNET-Lite-3/archive/3.0.7.zip && \ 
  unzip *.zip && \
  mv Super* supernet && \
  rm *.zip  && \
  cd /supernet && \
  chmod a+x supernet && \
  rm -Rf *.exe src changelogs

# RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

VOLUME /supernet

ENV NXTNET test       
# when running the container, you can override that using -e "NXTNET=main"

COPY ./nxt-main.properties /supernet/conf/
COPY ./nxt-test.properties /supernet/conf/
COPY ./start-supernet.sh /supernet/

WORKDIR "/supernet"

# default is port 7110
CMD ["/supernet/supernet"] 