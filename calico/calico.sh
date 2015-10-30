#!/bin/sh
n=${1:-1}
sudo calicoctl checksystem --fix
sudo calicoctl node --ip=172.17.8.10${n}
export DOCKER_HOST=localhost:2377
