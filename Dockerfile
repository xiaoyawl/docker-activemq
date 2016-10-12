FROM benyoo/alpine:openjdk-8-jre-20161012
MAINTAINER from www.dwhd.org by lookback (mondeolove@gmail.com)

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=5.13.4

LABEL name="ActiveMQ" version=$VERSION

ENV INSTALL_DIR=/opt/apache-activemq \
        TEMP_DIR=/tmp/apache-activemq

RUN set -x && \
        apk --update --no-cache upgrade && \
        apk add --no-cache curl bash tar && \
        mkdir -p ${INSTALL_DIR} ${TEMP_DIR} && \
        curl -Lk "$MIRROR/activemq/${VERSION}/apache-activemq-${VERSION}-bin.tar.gz" | tar xz -C /opt/apache-activemq --strip-components=1 && \
        apk del curl && \
        rm -rf /var/cache/apk/*

# expose below ports
EXPOSE 1883 5672 8161 61613 61614 61616

CMD ["/opt/apache-activemq/bin/activemq", "console"]
