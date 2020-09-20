FROM ubuntu:20.04

# Setup APT

RUN apt-get update \
    && apt-get upgrade -y

# Basic commands

RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    cmake \
    gdb \
    gnupg \
    make \
    ninja-build \
    python \
    snapd \
    software-properties-common \
    ssh-client \
    unzip \
    wget \
    xz-utils \
    && true

RUN systemctl enable snapd

# Install latest git

RUN add-apt-repository ppa:git-core/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends git
