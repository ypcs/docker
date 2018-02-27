FROM ypcs/debian:sid

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        nodejs \
        npm && \
    /usr/local/sbin/docker-cleanup
