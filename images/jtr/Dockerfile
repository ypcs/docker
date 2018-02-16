FROM ypcs/debian:jessie

ENV JOHN_VERSION 1.8.0-jumbo-1
ENV JOHN_SHA256 XX

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        build-essential \
        libssl-dev \
        libssl1.0.0 \
        libkrb5-3 \
        libgmp10 \
        libgmp-dev \
        zlib1g-dev \
        libnss3-dev \
        libkrb5-dev \
        wget && \
    cd /usr/src && \
    wget "http://www.openwall.com/john/j/john-${JOHN_VERSION}.tar.xz" && \
    tar xJf "john-${JOHN_VERSION}.tar.xz" && \
    cd john-* && \
    cd src && \
    ./configure && \
    make && \
    cd .. &&  \
    cp -R run /usr/local/bin && \
    cd .. && \
    rm -rf john-* && \
    apt-get --assume-yes remove \
        build-essential \
        libssl-dev \
        libgmp-dev \
        zlib1g-dev \
        libkrb5-dev \
        libnss3-dev && \
    /usr/local/sbin/docker-cleanup

