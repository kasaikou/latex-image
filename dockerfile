ARG baseimage=ubuntu:20.04
ARG aptmirror=archive.ubuntu.com

FROM ${baseimage}

ARG aptmirror
RUN sed -i "s@archive.ubuntu.com@${aptmirror}@g" /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=nointeractive \
    TZ=UTC \
    apt-get install -y --no-install-recommends \
    sudo \
    tzdata \
    wget \
    tar \
    curl \
    unzip \
    software-properties-common

RUN apt-get install -y --no-install-recommends perl && \
    wget http://ftp.riken.go.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar xvf install-tl-unx.tar.gz && \
    cd install-tl-2* && \
    echo I | ./install-tl -no-gui -repository http://ftp.riken.go.jp/pub/CTAN/systems/texlive/tlnet

ENV PATH=${PATH}:/usr/local/texlive/2022/bin/x86_64-linux
RUN tlmgr install collection-langjapanese collection-langcjk
