FROM ypcs/debian:stretch
MAINTAINER Ville Korhonen <ville@xd.fi>

ADD scripts/*.sh /tmp/prepare/
RUN  for f in /tmp/prepare/*.sh ; do sh "$f" ; done && rm -rf /tmp/prepare

CMD ["echo", "hello", "world"]
