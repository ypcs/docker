FROM ypcs/debian:jessie

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

# Heavily based on upstream Docker config, but we're using
# packages from Debian

ENV PHP_VERSION 5

RUN \
    docker-upgrade && \
    apt-get --assume-yes install \
    php-db \
	php${PHP_VERSION}-fpm && \
    docker-cleanup

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
    } |tee /etc/php${PHP_VERSION}/fpm/pool.d/zz-docker.conf && \
    sed -i "s/^listen = .*/listen = 9000/g" /etc/php${PHP_VERSION}/fpm/pool.d/www.conf && \
    if [ -x "/usr/sbin/php${PHP_VERSION}-fpm" ] ; then \
        ln -sf "/usr/sbin/php${PHP_VERSION}-fpm" "/usr/sbin/php-fpm${PHP_VERSION}" ; \
    fi

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www/html
EXPOSE 9000
CMD ["sh", "-c", "php-fpm${PHP_VERSION}"]