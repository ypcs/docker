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
        php-zip && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/lib/apt/lists/partial

WORKDIR /tmp

RUN \
    curl -fSL "https://github.com/drush-ops/drush/releases/download/${DRUSH_VERSION}/drush.phar" -o drush.phar && \
    echo "${DRUSH_SHA256} *drush.phar" |sha256sum -c - && \
    mv drush.phar /usr/local/bin/drush && \
    chmod +x /usr/local/bin/drush

WORKDIR /var/www/html
RUN \
    drush \
        pm-download \
        --yes \
        --destination=/var/www \
        --drupal-project-rename="html" \
        "drupal-${DRUPAL_VERSION}"
