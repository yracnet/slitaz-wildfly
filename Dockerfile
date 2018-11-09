# Slitaz+Wildlfy
#
FROM slitaz/slitaz-base
LABEL maintainer="Willyams Ricardo <yracnet@gmail.com>"

# wildfly environment
ENV URL_OPENJDK   http://download.java.net/java/GA/jdk9/9/binaries/openjdk-9_linux-x64_bin.tar.gz
ENV URL_WILDLFY   http://download.jboss.org/wildfly/14.0.1.Final/wildfly-14.0.1.Final.tar.gz
ENV SERVER_RUN    /server/wildfly
ENV SERVER_MOD    /server/module
ENV SERVER_JDK    /server/jdk

# install openjdk & wildfly
RUN echo 'start install openjdk and wildlfy' \
    && export  \
    && wget -O openjdk.tar "$URL_OPENJDK" \
    && wget -O wildfly.tar "$URL_WILDLFY" \
    && /usr/sbin/useradd --create-home --home-dir /server --shell /bin/bash server \
    && tar zxf /root/openjdk.tar --strip=1 -C /server/openjdk \
    && tar zxf /root/wildfly.tar --strip=1 -C /server/wildfly \
    && chown -R server:server /server \
    && mkdir -p /server/module \
    && chown server:server /server/module \
    && rm -f /root/openjdk.tar \
    && rm -f /root/wildfly.tar \
    && rm -rf /tmp/* /var/tmp/*

# run jserver
WORKDIR /server/openjdk
VOLUME /server/openjdk
WORKDIR /server/module
VOLUME /server/module
EXPOSE 8080
EXPOSE 8443
EXPOSE 9990
USER scm
CMD ["/server/wildlfy/bin/standalone.sh -c standalone-full.xml"]
