# Slitaz+Wildlfy
#
FROM centos
LABEL maintainer="Willyams Ricardo <yracnet@gmail.com>"

# wildfly environment
#ENV URL_OPENJDK   http://download.java.net/java/GA/jdk9/9/binaries/openjdk-9_linux-x64_bin.tar.gz
#ENV URL_WILDLFY   http://download.jboss.org/wildfly/14.0.1.Final/wildfly-14.0.1.Final.tar.gz
ENV URL_OPENJDK   http://172.23.243.134/openjdk-9_linux-x64_bin.tar.gz
ENV URL_WILDLFY   http://172.23.243.134/wildfly-14.0.1.Final.tar.gz
ENV URL_MODULES   http://172.23.243.134/modules.tar.gz
ENV SERV_WILDFLY    /serv/wildfly
ENV SERV_MODULES    /serv/modules
ENV SERV_OPENJDK    /serv/openjdk

# install openjdk & wildfly
RUN adduser -d /serv -s /bin/bash serv
#RUN mkdir -p "$SERV_OPENJDK"
#RUN mkdir -p "$SERV_WILDFLY"
#RUN mkdir -p "$SERV_MODULES"
#RUN curl -Lks "$URL_OPENJDK" -o openjdk.tar && tar zxf openjdk.tar -C "$SERV_OPENJDK" --strip=1 && rm -f openjdk.tar && rm 
#RUN curl -Lks "$URL_WILDLFY" -o wildfly.tar && tar zxf wildfly.tar -C "$SERV_WILDFLY" --strip=1 && rm -f wildfly.tar
#RUN curl -Lks "$URL_MODULES" -o modules.tar && tar zxf modules.tar -C "$SERV_MODULES" --strip=1 && rm -f modules.tar
#RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN chown -R serv:serv /serv
RUN ls /serv

# run jserver
WORKDIR /serv/openjdk
VOLUME  /serv/openjdk
WORKDIR /serv/wildfly
VOLUME  /serv/wildfly
WORKDIR /serv/modules
VOLUME  /serv/modules
EXPOSE 8080
EXPOSE 8443
EXPOSE 9990
USER serv
CMD ["/serv/wildlfy/bin/standalone.sh"]