FROM quay.io/podman/stable:v3.4.4

LABEL org.opencontainers.image.authors="Adrian Riobo <adrian.riobo.lorenzo@gmail.com>"

ARG KIND_VERSION=0.12.0  
ARG K8S_VERSION=1.23.0 
ARG SOLANA_VERSION=1.9.12

ENV SOLANA_INSTALLER_URL https://release.solana.com/v$SOLANA_VERSION/install
ENV KIND_EXPERIMENTAL_PROVIDER podman

RUN curl -Lo /tmp/kubernetes-client-linux-amd64.tar.gz https://dl.k8s.io/v${K8S_VERSION}/kubernetes-client-linux-amd64.tar.gz \
    && tar -xzvf /tmp/kubernetes-client-linux-amd64.tar.gz -C /tmp \
    && mv /tmp/kubernetes/client/bin/kubectl /usr/local/bin \
    && curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v$KIND_VERSION/kind-$(uname)-amd64 \
    && chmod +x ./kind \
    && mv ./kind /usr/local/bin \
    && rm -rf /tmp/* \
    && sh -c "$(curl -sSfL ${SOLANA_INSTALLER_URL})"

ENV PATH "/root/.local/share/solana/install/active_release/bin:$PATH"

ADD entrypoint.sh /usr/local/bin

ADD manifests /opt/manifests

ENTRYPOINT entrypoint.sh