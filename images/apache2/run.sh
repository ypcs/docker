#!/bin/sh
set -e

. /etc/apache2/envvars
mkdir -p "${APACHE_RUN_DIR}"
exec /usr/sbin/apache2 -DFOREGROUND
