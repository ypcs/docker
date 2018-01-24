FROM ypcs/debian:stretch

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

# Heavily based on upstream Docker config, but we're using
# packages from Debian

ENV PHP_VERSION 7.0

RUN \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get --assume-yes install \
    php-db \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-gd \
	php${PHP_VERSION}-imap \
	php${PHP_VERSION}-intl \
	php${PHP_VERSION}-json \
	php${PHP_VERSION}-mbstring \
	php${PHP_VERSION}-mcrypt \
	php${PHP_VERSION}-mysql \
	php${PHP_VERSION}-soap \
	php${PHP_VERSION}-xml && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/lib/apt/lists/partial

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
    sed -i "s/^listen = .*/listen = 9000/g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www/html
EXPOSE 9000
CMD ["sh", "-c", "php-fpm${PHP_VERSION}"]
