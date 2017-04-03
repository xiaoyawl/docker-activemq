# docker-ActiveMQ

[![](https://images.microbadger.com/badges/image/benyoo/activemq.svg)](https://microbadger.com/images/benyoo/activemq "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/benyoo/activemq.svg)](https://microbadger.com/images/benyoo/activemq "Get your own version badge on microbadger.com") [![Docker Pulls](https://img.shields.io/docker/pulls/benyoo/activemq.svg?maxAge=2592000)](https://hub.docker.com/r/benyoo/activemq/) 

[Docker](https://www.docker.io/) file for trusted builds of [ActiveMQ](http://activemq.apache.org/) on https://registry.hub.docker.com/u/benyoo/activemq/.

Run the latest container with:

    docker pull benyoo/activemq
    docker run -p 61616:61616 -p 8161:8161 benyoo/activemq

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
docker run -p 61616:61616 -p 8161:8161 -e ACTIVEMQ_CONF=/etc/activemq/conf -e ACTIVEMQ_DATA=var/lib/activemq/data benyoor/activemq
```

As an alternative you can just mount your persistent config and data directories into the default location:
```bash
mkdir -p /var/activemq/data && chown -R 400:400 /var/activemq/data
docker run -p 61616:61616 -p 8161:8161 -v /opt/activemq/conf:/opt/activemq/conf -v /var/activemq/data:/var/activemq/data benyoo/activemq
```

## Zookeeper + ActiveMQ

```bash
mkdir -p /etc/{activemq,zookeeper}
curl -Lks 'https://github.com/xiaoyawl/docker-activemq/raw/master/docker-compose-zk-mq.yml' > /data/docker-compose.yml
curl -Lks 'https://github.com/xiaoyawl/docker-activemq/raw/master/activemq.xml' > /etc/activemq/activemq.xml

# sed -ri 's/(MYID=).*/\11/;s/(SERVERS=).*/\1Node1,Node2,Node3,Node4,Node5/' /data/docker-compose.yml #Node1 setting
# sed -ri 's/(hostname=").*/\1Node1"/;s/(zkAddress=").*/\1Node1:2181,Node2:2181,Node3:2181,Node4:2181,Node5:2181"/' /etc/activemq/activemq.xml

# sed -ri 's/(MYID=).*/\12/;s/(SERVERS=).*/\1Node1,Node2,Node3,Node4,Node5/' /data/docker-compose.yml #Node2 setting
# sed -ri 's/(hostname=").*/\1Node1"/;s/(zkAddress=").*/\1Node1:2181,Node2:2181,Node3:2181,Node4:2181,Node5:2181"/' /etc/activemq/activemq.xml

# sed -ri 's/(MYID=).*/\13/;s/(SERVERS=).*/\1Node1,Node2,Node3,Node4,Node5/' /data/docker-compose.yml #Node3 setting
# sed -ri 's/(hostname=").*/\1Node1"/;s/(zkAddress=").*/\1Node1:2181,Node2:2181,Node3:2181,Node4:2181,Node5:2181"/' /etc/activemq/activemq.xml

# sed -ri 's/(MYID=).*/\14/;s/(SERVERS=).*/\1Node1,Node2,Node3,Node4,Node5/' /data/docker-compose.yml #Node4 setting
# sed -r 's/(hostname=").*/\1Node1"/;s/(zkAddress=").*/\1Node1:2181,Node2:2181,Node3:2181,Node4:2181,Node5:2181"/' /etc/activemq/activemq.xml

# sed -ri 's/(MYID=).*/\15/;s/(SERVERS=).*/\1Node1,Node2,Node3,Node4,Node5/' /data/docker-compose.yml #Node5 setting
# sed -ri 's/(hostname=").*/\1Node1"/;s/(zkAddress=").*/\1Node1:2181,Node2:2181,Node3:2181,Node4:2181,Node5:2181"/' /etc/activemq/activemq.xml

#vim /etc/activemq/activemq.xml
docker-compose -f /data/docker-compose.yml up -d
```

