FROM ypcs/debian:buster

ENV HASHCAT_VERSION 3.6.0
ENV HASHCAT_UTILS_VERSION 1.8

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get install --assume-yes \
        ocl-icd-libopencl1 \
        clinfo && \
    /usr/local/sbin/docker-cleanup

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get install --assume-yes \
        git \
        build-essential && \
    cd /usr/src && \
    git clone --depth=1 https://github.com/hashcat/hashcat.git hashcat && \
    git clone --depth=1 https://github.com/hashcat/hashcat-utils hashcat-utils && \
    cd hashcat && \
    git submodule update --init && \
    make && \
    make install && \
    cd ../hashcat-utils/src && \
    make && \
    cp ../bin/* /usr/local/bin/ && \
    cd ../.. && \
    rm -rf hashcat hashcat-utils && \
    apt-get remove --assume-yes \
        git \
        build-essential && \
    /usr/local/sbin/docker-cleanup

