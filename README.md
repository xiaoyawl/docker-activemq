docker-activemq
===============

[![](https://images.microbadger.com/badges/image/benyoo/activemq.svg)](https://microbadger.com/images/benyoo/activemq "Get your own image badge on microbadger.com")
[![Docker Pulls](https://img.shields.io/docker/pulls/benyoo/activemq.svg?maxAge=2592000)](https://hub.docker.com/r/benyoo/activemq/)

[Docker](https://www.docker.io/) file for trusted builds of [ActiveMQ](http://activemq.apache.org/) on https://registry.hub.docker.com/u/benyoo/activemq/.

Run the latest container with:

    docker pull benyoo/activemq
    docker run -p 61616:61616 -p 8161:8161 rmohr/activemq

The JMX broker listens on port 61616 and the Web Console on port 8161.

Port Map
--------

    61616 JMS
    8161  UI
    5672  AMQP
    61613 STOMP
    1883  MQTT
    61614 WS

Customizing configuration and persistence location
--------------------------------------------------

ActiveMQ checks your environment for the variables *ACTIVEMQ_BASE*, *ACTIVEMQ_CONF* and *ACTIVEMQ_DATA*.
Just override them with your desired location:
```bash
docker run -p 61616:61616 -p 8161:8161 -e ACTIVEMQ_CONF=/etc/activemq/conf -e ACTIVEMQ_DATA=var/lib/activemq/data rmohr/activemq
```

As an alternative you can just mount your persistent config and data directories into the default location:
```bash
mkdir -p /var/activemq/data && chown -R 400:400 /var/activemq/data
docker run -p 61616:61616 -p 8161:8161 -v /opt/activemq/conf:/opt/activemq/conf -v /var/activemq/data:/var/activemq/data rmohr/activemq
```
