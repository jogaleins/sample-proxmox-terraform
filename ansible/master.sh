#!/bin/bash
export INSTALL_K3S_VERSION="v1.26.7+k3s1"
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.26.7+k3s1" K3S_TOKEN=SECRET sh -s - server --cluster-init --flannel-iface=eth0 --disable servicelb
sleep 60