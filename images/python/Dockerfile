FROM ypcs/debian:stretch

RUN \
    docker-upgrade && \
    apt-get --assume-yes install \
        python3 \
        python3-dev \
        python3-pip && \
    docker-cleanup
