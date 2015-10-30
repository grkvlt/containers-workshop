#!/bin/bash

docker run -e CALICO_IP=192.168.1.4 --name workload-D -tid busybox
docker run -e CALICO_IP=192.168.1.5 --name workload-E -tid busybox

calicoctl endpoint $(calicoctl container workload-D endpoint-id show) profile append PROF_D
calicoctl endpoint $(calicoctl container workload-E endpoint-id show) profile append PROF_A_C_E

