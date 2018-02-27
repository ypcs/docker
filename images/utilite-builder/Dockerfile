FROM ypcs/debian:stretch

ENV ARCH=arm
ENV CROSS_COMPILE arm-linux-gnueabihf-

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        build-essential \
        gcc-arm-none-eabi \
        gcc-arm-linux-gnueabi \
        gcc-arm-linux-gnueabihf \
        git \
        libncurses5 \
        libncurses5-dev \
        libncursesw5 \
        libncursesw5-dev \
        lzop \
        pkg-config \
        u-boot-tools && \
    /usr/local/sbin/docker-cleanup

RUN \
    git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git /usr/src/linux
