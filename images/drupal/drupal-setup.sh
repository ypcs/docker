#!/bin/sh
set -e

DRUPAL_SITE="${DRUPAL_SITE:-Example Site}"
DRUPAL_USERNAME="${DRUPAL_USERNAME:-admin}"
DRUPAL_PASSWORD="${DRUPAL_PASSWORD:-admin}"
DRUPAL_DB_HOST="${DRUPAL_DB_HOST:-db}"
DRUPAL_DB="${DRUPAL_DB:-drupal}"
DRUPAL_DB_USER="${DRUPAL_DB_USER:-drupal}"
DRUPAL_DB_PASSWORD="${DRUPAL_DB_PASSWORD:-drupal}"

DRUPAL_ROOT="${DRUPAL_ROOT:-${DOCUMENT_ROOT:-/var/www/html}}"

if [ ! -f "${DRUPAL_ROOT}/install.php" ]
then
    echo "No Drupal installation found, exiting!"
    exit 1
fi

cd "${DRUPAL_ROOT}"

drush site-install standard -y \
    --db-url="mysql://${DRUPAL_DB_USER}:${DRUPAL_DB_PASSWORD}@${DRUPAL_DB_HOST}/${DRUPAL_DB}" \
    --site-name="${DRUPAL_SITE}" \
    --account-name="${DRUPAL_USERNAME}" \
    --account-pass="${DRUPAL_PASSWORD}"
