#!/bin/bash

docker exec workload-A ping -c 4 192.168.1.3
docker exec workload-A ping -c 4 192.168.1.5

docker exec workload-A ping -c 4 192.168.1.2 -t 10
docker exec workload-A ping -c 4 192.168.1.4 -t 10

