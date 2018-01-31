FROM ypcs/debian:stretch

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get install --no-install-recommends --no-install-suggests --assume-yes \
        apache2 && \
    /usr/local/sbin/docker-cleanup

RUN \
    ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE 80
STOPSIGNAL SIGTERM

COPY run.sh /run.sh
CMD ["/run.sh"]

