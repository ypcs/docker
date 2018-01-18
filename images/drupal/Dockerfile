FROM ypcs/php:7.0

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

RUN \
    apt-get update && \
    apt-get --assume-yes upgrade && \
    apt-get --assume-yes install curl

WORKDIR /var/www/html

ENV DRUPAL_VERSION 7.56
ENV DRUPAL_MD5 5d198f40f0f1cbf9cdf1bf3de842e534

RUN curl -fSL "https://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz" -o drupal.tar.gz \
	&& echo "${DRUPAL_MD5} *drupal.tar.gz" | md5sum -c - \
	&& tar -xz --strip-components=1 -f drupal.tar.gz \
	&& rm drupal.tar.gz \
	&& chown -R www-data:www-data sites
