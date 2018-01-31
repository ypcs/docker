#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm${PHP_VERSION:-7.0} "$@"
fi

exec "$@"
