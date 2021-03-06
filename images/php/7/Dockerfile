FROM ypcs/debian:stretch

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

# Heavily based on upstream Docker config, but we're using
# packages from Debian

ENV DOCUMENT_ROOT /var/www/html
ENV PHP_VERSION 7.0
ENV SITE_URL http://localhost

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        msmtp-mta \
        php-db \
    	php${PHP_VERSION}-fpm && \
    /usr/local/sbin/docker-cleanup

RUN \
    mkdir -p /run/php && \
    { \
        echo '[global]' ; \
        echo 'error_log = /proc/self/fd/2' ; \
        echo ; \
        echo '[www]' ; \
        echo 'access.log = /proc/self/fd/2' ; \
        echo 'clear_env = no' ; \
        echo 'catch_workers_output = yes' ; \
    } |tee /etc/php/${PHP_VERSION}/fpm/pool.d/zz-docker.conf && \
    sed -i "s/^listen = .*/listen = 9000/g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

RUN mkdir -p /entrypoint-init.d
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www/html
EXPOSE 9000
CMD ["sh", "-c", "php-fpm${PHP_VERSION}"]
