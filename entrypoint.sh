#!/bin/bash

CLUSTER_NAME=solana-dev

# Fix podman conf
sed -i '/^utsns/d' /etc/containers/containers.conf

# Create netwrk
podman network create kind

# Start cluster
if [[ -f /etc/kind/config.yaml ]]; then 
  echo "kind with config"
  kind create cluster --name ${CLUSTER_NAME} --config /etc/kind/config.yaml
else 
  echo "kind without config"
  kind create cluster --name ${CLUSTER_NAME}
fi

mkdir -p /etc/kind/logs
kind --name ${CLUSTER_NAME} export logs /etc/kind/logs
tail -f "/etc/kind/logs/${CLUSTER_NAME}-control-plane/journal.log"