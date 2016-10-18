FROM benyoo/alpine:openjdk-8-jre-20161012
MAINTAINER from www.dwhd.org by lookback (mondeolove@gmail.com)

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=5.13.4

LABEL name="ActiveMQ" version=$VERSION

ENV INSTALL_DIR=/opt/activemq \
	TEMP_DIR=/tmp/activemq \
	ACTIVEMQ_TCP=61616 \
	ACTIVEMQ_AMQP=5672 \
	ACTIVEMQ_STOMP=61613 \
	ACTIVEMQ_MQTT=1883 \
	ACTIVEMQ_WS=61614 \
	ACTIVEMQ_UI=8161

RUN set -x && \
	DOWNLOAD=${DOWNLOAD:-$MIRROR/activemq/${VERSION}/apache-activemq-${VERSION}-bin.tar.gz} && \
	apk --update --no-cache upgrade && \
	apk add --no-cache curl bash tar iproute2 && \
	addgroup -g 400 -S activemq && \
	adduser -S -H -G activemq -u 400 -h $INSTALL_DIR -g 'ActiveMQ' activemq && \
	mkdir -p ${INSTALL_DIR} ${TEMP_DIR} && \
	curl -Lk "$DOWNLOAD" | tar xz -C ${INSTALL_DIR} --strip-components=1 && \
	chown -R activemq:activemq $INSTALL_DIR && \
	apk del curl iptables && \
	rm -rf /var/cache/apk/*

USER activemq
ENV PATH=$INSTALL_DIR/bin:$PATH \
	TERM=linux

WORKDIR $INSTALL_DIR
EXPOSE $ACTIVEMQ_TCP $ACTIVEMQ_AMQP $ACTIVEMQ_STOMP $ACTIVEMQ_MQTT $ACTIVEMQ_WS $ACTIVEMQ_UI

CMD ["activemq", "console"]
