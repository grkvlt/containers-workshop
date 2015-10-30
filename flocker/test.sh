#!/bin/sh
set -x # DEBUG

curl --cacert /etc/flocker/cluster.crt --cert /etc/flocker/user.crt --key /etc/flocker/user.key https://192.168.101.11:4523/v1/configuration/containers
docker run -v apples:/data --volume-driver flocker busybox sh -c "echo hello > /data/file.txt"
docker run -v apples:/data --volume-driver flocker busybox sh -c "cat /data/file.txt"

