#!/bin/bash

docker run -e CALICO_IP=192.168.1.1 --name workload-A -tid busybox
docker run -e CALICO_IP=192.168.1.2 --name workload-B -tid busybox
docker run -e CALICO_IP=192.168.1.3 --name workload-C -tid busybox

calicoctl profile add PROF_A_C_E
calicoctl profile add PROF_B
calicoctl profile add PROF_D

calicoctl endpoint $(calicoctl container workload-A endpoint-id show) profile append PROF_A_C_E
calicoctl endpoint $(calicoctl container workload-B endpoint-id show) profile append PROF_B
calicoctl endpoint $(calicoctl container workload-C endpoint-id show) profile append PROF_A_C_E

