FROM ypcs/drupal:7

ENV CIVICRM_DATABASE_USER civicrm
ENV CIVICRM_DATABASE_PASSWORD civicrm
ENV CIVICRM_DATABASE_HOST civicrm
ENV CIVICRM_DATABASE_NAME civicrm

ENV CIVICRM_VERSION 4.7.29
ENV CIVICRM_SHA256 5a6dd2e096ddabe95f73c8f07f9329dc607489170f51ecdc45d2f211a443bdae

ENV CIVICRM_CV_SHA256 3708d502d1a6d4bcdf812908ed141a19fa0fc14d20f5a0d755bfa0af9e6b6b14 
ENV CIVICRM_CV_URL https://download.civicrm.org/cv/cv.phar

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

RUN \
    /usr/local/sbin/docker-upgrade &&\
    apt-get update && \
    apt-get --assume-yes upgrade && \
    apt-get --assume-yes install \
        curl \
        mariadb-client \
        ssmtp && \
    /usr/local/sbin/docker-cleanup

RUN \
    curl -fSL "${CIVICRM_CV_URL}" -o /usr/local/bin/cv && \
    echo "${CIVICRM_CV_SHA256} /usr/local/bin/cv" |sha256sum -c - && \
    chmod +x /usr/local/bin/cv

# Disable PHP daemon mode
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf

COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
RUN chown root:mail /etc/ssmtp/ssmtp.conf \
    && chmod 640 /etc/ssmtp/ssmtp.conf \
    && usermod -a -G mail www-data \
    && echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /etc/php/7.0/fpm/conf.d/mail.ini

# Install default error pages
COPY 404.html /var/www/html/404.html
COPY 50x.html /var/www/html/50x.html

COPY download.sh /usr/local/sbin/civicrm-install
COPY setup.sh /usr/local/sbin/civicrm-setup

WORKDIR /var/www

