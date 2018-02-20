#!/bin/sh
set -e

DOCUMENT_ROOT="${DOCUMENT_ROOT:-/var/www/html}"

echo "Change file ownership to root:www-data."
find "${DOCUMENT_ROOT}" -exec chown root:www-data '{}' \;

echo "Change file permissions (d: 0755, f: 0644)."
find "${DOCUMENT_ROOT}" -type d -exec chmod 0755 '{}' \;
find "${DOCUMENT_ROOT}" -type f -exec chmod 0644 '{}' \;

echo "Add write permissions to user content."
find "${DOCUMENT_ROOT}/sites" -type d -name files -exec chmod 0770 '{}' \;
find "${DOCUMENT_ROOT}/sites" -type d -path '*/files/*' -exec chmod 0770 '{}' \;
find "${DOCUMENT_ROOT}/sites" -type f -path '*/files/*' -exec chmod 0660 '{}' \;

# needed by civicrm
find "${DOCUMENT_ROOT}/sites" -maxdepth 1 -type d -name default -exec chmod 0770 '{}' \;

