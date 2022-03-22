#!/bin/bash

CLUSTER_NAME=solana-dev

# Fix podman conf
sed -i '/^utsns/d' /etc/containers/containers.conf

# Create netwrk
podman network create kind

# Start cluster
kind create cluster --name ${CLUSTER_NAME} --config /opt/manifests/kind.yaml

mkdir -p /etc/kind/logs
kind --name ${CLUSTER_NAME} export logs /etc/kind/logs

#validator_ip=$(kubectl get svc validator -ojsonpath='{.spec.clusterIP}')
#solana config set --url "http://${validator_ip}:8899"
#curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":1, "method":"getClusterNodes"}' http://127.0.0.1:8899

tail -f "/etc/kind/logs/${CLUSTER_NAME}-control-plane/journal.log"