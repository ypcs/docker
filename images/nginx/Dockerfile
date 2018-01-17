FROM ypcs/debian:stretch

# Heavily based on nginx upstreams Docker config, however
# we use package in Debian instead of upstream.

RUN \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends --no-install-suggests --assume-yes nginx-full && \
    apt-get clean && \
    apt-get autoclean

RUN \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]

