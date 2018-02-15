#!/bin/sh
set -e

find /var/www/html -type d -exec chmod 0750 '{}' \; && \
find /var/www/html -type f -exec chmod 0640 '{}' \; && \
find /var/www/html/sites -type d -name files -exec chmod 0770 '{}' \; && \
find /var/www/html/sites -type d -path '*/files/*' -exec chmod 0770 '{}' \; && \
find /var/www/html/sites -type f -path '*/files/*' -exec chmod 0660 '{}' \;

