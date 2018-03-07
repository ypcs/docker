FROM ypcs/debian:buster

ENV HASHCAT_VERSION v4.1.0
ENV HASHCAT_UTILS_VERSION v1.8

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
    git clone https://github.com/hashcat/hashcat.git hashcat && \
    git clone https://github.com/hashcat/hashcat-utils hashcat-utils && \
    cd hashcat && \
    git checkout ${HASHCAT_VERSION} && \
    git submodule update --init && \
    make && \
    make install && \
    cd ../hashcat-utils/src && \
    git checkout ${HASHCAT_UTILS_VERSION} && \
    make && \
    cp *.bin /usr/local/bin/ && \
    cp *.pl /usr/local/bin/ && \
    cd ../.. && \
    rm -rf hashcat hashcat-utils && \
    apt-get remove --assume-yes \
        git \
        build-essential && \
    /usr/local/sbin/docker-cleanup

