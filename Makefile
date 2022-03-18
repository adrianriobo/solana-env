
KIND_VERSION ?= 0.12.0 
K8S_VERSION ?= 1.23.0
ENV_NAME ?= solana-dev
ENV_IMAGE ?= quay.io/ariobolo/solana-env:latest

.PHONY: create-env

create-env:
	sudo podman run --privileged -d --rm --name $(ENV_NAME) -v /dev/mapper:/dev/mapper $(ENV_IMAGE)

.PHONY: destroy-env

destroy-env:
	sudo podman stop $(ENV_NAME)