FROM ypcs/debian:buster

# In order to gracefully stop systemd we need to set the stop signal to
# SIGRTMIN+3 and set the container environment variable
STOPSIGNAL SIGRTMIN+3
ENV container docker

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        libpam-systemd \
        systemd \
        systemd-sysv && \
    /usr/local/sbin/docker-cleanup

# No need for graphical.target here
RUN systemctl set-default multi-user.target

CMD ["/sbin/init"]
