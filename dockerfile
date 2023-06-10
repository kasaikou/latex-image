ARG baseimage
ARG aptmirror=archive.ubuntu.com

FROM ${baseimage}
RUN sed -i "s@archive.ubuntu.com@${aptmirror}@g" /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=nointeractive \
    TZ=UTC \
    apt-get install -y --no-install-recommends \
    tzdata \
    wget \
    tar \
    curl \
    unzip

RUN apt-get install -y --no-install-recommends perl && \
    wget http://ftp.riken.go.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar xvf install-tl-unx.tar.gz && \
    cd install-tl-2* && \
    echo I | ./install-tl -no-gui -repository http://ftp.riken.go.jp/pub/CTAN/systems/texlive/tlnet
