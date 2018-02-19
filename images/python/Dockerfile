FROM ypcs/debian:stretch

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes --no-install-recommends install \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-wheel && \
    /usr/local/sbin/docker-cleanup
