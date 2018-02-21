FROM ypcs/civicrm:latest

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        git \
        mkdocs \
        mkdocs-bootstrap
    /usr/local/sbin/docker-cleanup

RUN \
    mkdir -p /usr/local/share/doc && \
    git clone --depth=1 https://github.com/civicrm/civicrm-sysadmin-guide /usr/local/share/doc/civicrm-sysadmin-guide

RUN \
    mkdir -p /usr/local/share/doc && \
    git clone --depth=1 https://github.com/civicrm/civicrm-buildkit /usr/local/share/civicrm-buildkit
