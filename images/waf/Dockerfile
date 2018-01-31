FROM ypcs/apache2:latest
MAINTAINER Ville Korhonen <ville@xd.fi>

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

ENV DEBUG_MODE 0

RUN \
    apt-get update && \
    apt-get upgrade --assume-yes && \
    apt-get install --assume-yes \
        libapache2-mod-security2 \
        modsecurity-crs && \
    /usr/local/sbin/docker-cleanup

RUN \
    mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf && \
    if [ "${DEBUG_MODE}" = "1" ] ; then sed -i "s/SecRuleEngine DetectionOnly/SecRuleEngine On/" /etc/modsecurity/modsecurity.conf ; fi && \
    a2enmod security2
