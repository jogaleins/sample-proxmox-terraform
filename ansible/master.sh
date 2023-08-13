#!/bin/bash

curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET sh -s - server --cluster-init --flannel-iface=eth0 --disable servicelb
sleep 60