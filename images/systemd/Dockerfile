FROM ypcs/debian:buster

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        libpam-systemd \
        systemd \
        systemd-sysv && \
    /usr/local/sbin/docker-cleanup

CMD ["/sbin/init"]
