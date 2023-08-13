#!/bin/bash

curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET sh -s - server --server https://192.168.2.211:6443 --flannel-iface=eth0 --disable servicelb