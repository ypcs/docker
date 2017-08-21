FROM ypcs/debian:stretch
MAINTAINER Ville Korhonen <ville@xd.fi>

ADD prepare.sh /tmp/prepare.sh
RUN /bin/sh /tmp/prepare.sh && rm -f /tmp/prepare.sh

CMD ["echo", "hello", "world"]
