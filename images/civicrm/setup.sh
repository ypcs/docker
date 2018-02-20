#!/bin/sh
set -e

CIVICRM_DATABASE_HOST="${CIVICRM_DATABASE_HOST:-db}"
CIVICRM_DATABASE_USER="${CIVICRM_DATABASE_USER:-civicrm}"
CIVICRM_DATABASE_PASSWORD="${CIVICRM_DATABASE_PASSWORD:-civicrm}"
CIVICRM_DATABASE_NAME="${CIVICRM_DATABASE_NAME:-civicrm}"

CIVICRM_INSTALL_URL="${CIVICRM_INSTALL_URL:-http://web/sites/all/modules/civicrm/install/index.php}"

DRUPAL_DATABASE_HOST="${DRUPAL_DATABASE_HOST:-db}"
DRUPAL_DATABASE_USER="${DRUPAL_DATABASE_USER:-drupal}"
DRUPAL_DATABASE_PASSWORD="${DRUPAL_DATABASE_PASSWORD:-drupal}"
DRUPAL_DATABASE_NAME="${DRUPAL_DATABASE_NAME:-drupal}"


echo "Submit CiviCRM install request"
curl \
    -X POST \
    -F "mysql[server]=${CIVICRM_DATABASE_HOST}" \
    -F "mysql[user]=${CIVICRM_DATABASE_USER}" \
    -F "mysql[password]=${CIVICRM_DATABASE_PASSWORD}" \
    -F "mysql[database]=${CIVICRM_DATABASE_NAME}" \
    -F "drupal[server]=${DRUPAL_DATABASE_HOST}" \
    -F "drupal[user]=${DRUPAL_DATABASE_USER}" \
    -F "drupal[password]=${DRUPAL_DATABASE_PASSWORD}" \
    -F "drupal[database]=${DRUPAL_DATABASE_NAME}" \
    -F "go=1" \
    "${CIVICRM_INSTALL_URL}"

# force_reinstall=1
