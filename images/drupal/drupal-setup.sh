#!/bin/sh
set -e

DRUPAL_SITE="${DRUPAL_SITE:-Example Site}"
DRUPAL_USERNAME="${DRUPAL_USERNAME:-admin}"
DRUPAL_PASSWORD="${DRUPAL_PASSWORD:-admin}"
DRUPAL_DATABASE_HOST="${DRUPAL_DATABASE_HOST:-db}"
DRUPAL_DATABASE_NAME="${DRUPAL_DATABASE_NAME:-drupal}"
DRUPAL_DATABASE_USER="${DRUPAL_DATABASE_USER:-drupal}"
DRUPAL_DATABASE_PASSWORD="${DRUPAL_DATABASE_PASSWORD:-drupal}"

DRUPAL_ROOT="${DRUPAL_ROOT:-${DOCUMENT_ROOT:-/var/www/html}}"

if [ ! -f "${DRUPAL_ROOT}/install.php" ]
then
    echo "No Drupal installation found, exiting!"
    exit 1
fi

cd "${DRUPAL_ROOT}"

set +e
drush status bootstrap | grep -q Successful
STATUS="$?"
set -e

if [ "${STATUS}" = "1" ]
then
    drush site-install standard -y \
        --db-url="mysql://${DRUPAL_DATABASE_USER}:${DRUPAL_DATABASE_PASSWORD}@${DRUPAL_DATABASE_HOST}/${DRUPAL_DATABASE_NAME}" \
        --site-name="${DRUPAL_SITE}" \
        --account-name="${DRUPAL_USERNAME}" \
        --account-pass="${DRUPAL_PASSWORD}"
else
    echo "Drupal already bootstrapped, skipping site-install!"
fi
