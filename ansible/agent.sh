#!/bin/bash

export INSTALL_K3S_VERSION="v1.26.7+k3s1"
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.26.7+k3s1" K3S_TOKEN=SECRET sh -s - server --server https://192.168.2.211:6443 --flannel-iface=eth0 --disable servicelb