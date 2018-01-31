FROM ypcs/php:7.0

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

ENV DRUPAL_VERSION 7.x
ENV DRUSH_VERSION 8.1.15
ENV DRUSH_SHA256 6999d72e51577b1e20cfaec87152d9905b714f5812861692877b8424a4e2358a

RUN \
    apt-get update && \
    apt-get --assume-yes upgrade && \
    apt-get --assume-yes install \
        curl \
        php-zip \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-imap \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-mcrypt \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-soap \
        php${PHP_VERSION}-xml && \
    /usr/local/sbin/docker-cleanup

WORKDIR /tmp

RUN \
    curl -fSL "https://github.com/drush-ops/drush/releases/download/${DRUSH_VERSION}/drush.phar" -o drush.phar && \
    echo "${DRUSH_SHA256} *drush.phar" |sha256sum -c - && \
    mv drush.phar /usr/local/bin/drush && \
    chmod +x /usr/local/bin/drush

WORKDIR /var/www/html

# <https://www.drupal.org/node/244924>
RUN \
    drush \
        pm-download \
        --yes \
        --destination=/var/www \
        --drupal-project-rename="html" \
        "drupal-${DRUPAL_VERSION}" && \
    find /var/www/html -type d -exec chmod 0750 '{}' \; && \
    find /var/www/html -type f -exec chmod 0640 '{}' \; && \
    find /var/www/html/sites -type d -name files -exec chmod 0770 '{}' \; && \
    find /var/www/html/sites -type d -path '*/files/*' -exec chmod 0770 '{}' \; && \
    find /var/www/html/sites -type f -path '*/files/*' -exec chmod 0660 '{}' \;
