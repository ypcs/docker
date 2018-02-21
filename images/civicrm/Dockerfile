FROM ypcs/drupal:7

ENV CIVICRM_DATABASE_USER civicrm
ENV CIVICRM_DATABASE_PASSWORD civicrm
ENV CIVICRM_DATABASE_HOST civicrm
ENV CIVICRM_DATABASE_NAME civicrm

ENV CIVICRM_VERSION 4.7.29
ENV CIVICRM_SHA256 5a6dd2e096ddabe95f73c8f07f9329dc607489170f51ecdc45d2f211a443bdae
ENV CIVICRM_L10N_SHA256 d8955ed86167cf6543d649f19eaa8cc16e6443aaa33f4bd8e9499654c8389fd7

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
        mariadb-client && \
    /usr/local/sbin/docker-cleanup

RUN \
    curl -fSL "${CIVICRM_CV_URL}" -o /usr/local/bin/cv && \
    echo "${CIVICRM_CV_SHA256} /usr/local/bin/cv" |sha256sum -c - && \
    chmod +x /usr/local/bin/cv

COPY setup.sh /usr/local/sbin/civicrm-setup

RUN \
    cd /var/www/html/sites/all/modules && \
    curl -fSL "https://storage.googleapis.com/civicrm/civicrm-stable/${CIVICRM_VERSION}/civicrm-${CIVICRM_VERSION}-drupal.tar.gz" -o "civicrm.tar.gz" && \
    echo "${CIVICRM_SHA256} *civicrm.tar.gz" |sha256sum -c - && \
    curl -fSL "https://storage.googleapis.com/civicrm/civicrm-stable/${CIVICRM_VERSION}/civicrm-${CIVICRM_VERSION}-l10n.tar.gz" -o "civicrm-l10n.tar.gz" && \
    echo "${CIVICRM_L10N_SHA256} *civicrm-l10n.tar.gz" |sha256sum -c - && \
    tar xzf civicrm.tar.gz && \
    tar xzf civicrm-l10n.tar.gz && \
    rm -f civicrm.tar.gz civicrm-l10n.tar.gz

WORKDIR /var/www

