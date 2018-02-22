FROM ypcs/debian:stretch

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        redis-server
    /usr/local/sbin/docker-cleanup

EXPOSE 6379

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis-server"]
