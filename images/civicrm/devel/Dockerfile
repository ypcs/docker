FROM ypcs/civicrm:latest
ENV DOCUMENT_ROOT /var/www

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        git \
        mkdocs \
        mkdocs-bootstrap && \
    /usr/local/sbin/docker-cleanup

RUN \
    echo "TODO: install drupal"

RUN \
    echo "TODO: clone civicrm repository?"

RUN \
    echo "TODO: clone other civicrm docs, w/o shallow?"

RUN \
    mkdir -p /usr/local/share/doc && \
    git clone --depth=1 https://github.com/civicrm/civicrm-sysadmin-guide /usr/local/share/doc/civicrm-sysadmin-guide

RUN \
    mkdir -p /usr/local/share/doc && \
    git clone --depth=1 https://github.com/civicrm/civicrm-buildkit /usr/local/share/civicrm-buildkit