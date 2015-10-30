#!/bin/bash

calicoctl profile add redis
calicoctl pool add 192.168.123.0/23 --nat-outgoing

docker run -e CALICO_IP=192.168.123.10 -v /vagrant/redis-cluster/redis-master.conf:/usr/local/etc/redis/redis.conf \
  --name redis-master -d redis:3 redis-server /usr/local/etc/redis/redis.conf

sudo iptables -A PREROUTING -t nat -i eth1 -p tcp --dport 6379 -j DNAT --to-destination 192.168.123.10:6379

calicoctl endpoint $(calicoctl container redis-master endpoint-id show) profile append redis
calicoctl profile redis rule add inbound allow tcp to ports 6379

