FROM ypcs/debian:stretch

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        python3 \
        python3-dev \
        python3-pip && \
    /usr/local/sbin/docker-cleanup
