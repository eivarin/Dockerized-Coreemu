# syntax=docker/dockerfile:1
FROM ubuntu:22.04 AS base
LABEL Description="CORE Docker Ubuntu Image"

ARG TARGETARCH
ARG PREFIX=/usr/local
ARG BRANCH=master
ARG PROTOC_VERSION=3.19.6
ARG VENV_PATH=/opt/core/venv
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$PATH:${VENV_PATH}/bin"
WORKDIR /opt

# install system dependencies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    sudo \
    wget \
    tzdata \
    libpcap-dev \
    libpcre3-dev \
    libprotobuf-dev \
    libxml2-dev \
    protobuf-compiler \
    unzip \
    uuid-dev \
    iproute2 \
    iputils-ping \
    tcpdump \ 
    software-properties-common && \
    apt-get autoremove -y

# install core
RUN git clone https://github.com/coreemu/core && \
    cd core && \
    git checkout ${BRANCH} && \
    ./setup.sh && \
    PATH=/root/.local/bin:$PATH inv install -v -p ${PREFIX} && \
    cd /opt && \
    rm -rf ospf-mdr
    
RUN echo ${TARGETARCH} | sed s/arm64/aarch_64/ | sed s/amd64/x86_64/ >> /arch
# install emane
RUN export protocZipFile=protoc-${PROTOC_VERSION}-linux-$(cat /arch).zip && \
    wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/$protocZipFile && \
    mkdir protoc && \
    unzip $protocZipFile -d protoc && \
    git clone https://github.com/adjacentlink/emane.git && \
    cd emane && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    make -j$(nproc)  && \
    make install && \
    cd src/python && \
    make clean && \
    PATH=/opt/protoc/bin:$PATH make && \
    ${VENV_PATH}/bin/python -m pip install . && \
    cd /opt && \
    rm -rf protoc && \
    rm -rf emane && \
    rm -f $protocZipFile

WORKDIR /root

FROM base AS final

LABEL org.opencontainers.image.source=https://github.com/eivarin/Dockerized-Coreemu
LABEL org.opencontainers.image.description="A dockerized image of Coreemu with X11 Forwarding capabilities for native like UI"

RUN add-apt-repository ppa:wireshark-dev/stable -y

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    wireshark \
    traceroute \
    && apt-get autoremove -y

# CMD ["bash", "-c", "sudo /opt/core/venv/bin/core-daemon & sleep 1 ; /opt/core/venv/bin/core-gui"]
CMD ["bash", "-c", "sudo /opt/core/venv/bin/core-daemon"]