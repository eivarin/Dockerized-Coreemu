FROM ubuntu:22.04 AS base
ENV DEBIAN_FRONTEND=noninteractive
# install system dependencies
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt update && apt-get --no-install-recommends install -y \
    build-essential \
    git gcc make vim libtk-img bash xterm \
    sntp ntp wget lynx curl net-tools traceroute tcptraceroute \
    ipcalc socat hping3 httpie whois ngrep \
    tcpdump wireshark iperf iperf3 tshark openssh-server openssh-client openssh-sftp-server \
    vsftpd atftp atftpd apache2 mini-httpd openvpn isc-dhcp-server isc-dhcp-client \
    bind9 bind9-utils \
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
    python3-pip \
    python3-venv \
    automake \
    pkg-config \
    gcc \
    libev-dev \
    nftables \
    ethtool \
    tk \
    bash \
    python3-tk \
    libtool \
    gawk \
    libreadline-dev \
    software-properties-common && \
    apt-get autoremove -y

# syntax=docker/dockerfile:1
FROM base AS app
LABEL org.opencontainers.image.source=https://github.com/eivarin/Dockerized-Coreemu
LABEL org.opencontainers.image.description="A dockerized image of Coreemu with X11 Forwarding capabilities for native like UI"

ARG TARGETARCH
ARG PREFIX=/usr/local
ARG BRANCH=master
ARG PROTOC_VERSION=3.19.6
ARG VENV_PATH=/opt/core/venv
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$PATH:${VENV_PATH}/bin"
WORKDIR /opt

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

CMD ["bash", "-c", "sudo /opt/core/venv/bin/core-daemon"]