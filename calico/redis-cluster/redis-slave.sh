#!/bin/bash

n=${1:-1}

docker run -e CALICO_IP=192.168.123.1${n} -v /vagrant/redis-cluster/redis-slave.conf:/usr/local/etc/redis/redis.conf \
  --name redis-slave-${n} -d redis:3 redis-server /usr/local/etc/redis/redis.conf

sudo iptables -A PREROUTING -t nat -i eth1 -p tcp --dport 700${n} -j DNAT --to-destination 192.168.123.1${n}:6379

calicoctl endpoint $(calicoctl container redis-slave-${n} endpoint-id show) profile append redis
calicoctl profile redis rule add inbound allow tcp to ports 700${n}
