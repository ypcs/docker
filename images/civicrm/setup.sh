#!/bin/sh
set -e

CIVICRM_DATABASE_HOST="${CIVICRM_DATABASE_HOST:-db}"
CIVICRM_DATABASE_USER="${CIVICRM_DATABASE_USER:-civicrm}"
CIVICRM_DATABASE_PASSWORD="${CIVICRM_DATABASE_PASSWORD:-civicrm}"
CIVICRM_DATABASE_NAME="${CIVICRM_DATABASE_NAME:-civicrm}"

CIVICRM_INSTALL_URL="${CIVICRM_INSTALL_URL:-http://web/sites/all/modules/civicrm/install/index.php}"

DRUPAL_USERNAME="${DRUPAL_USERNAME:-admin}"
DRUPAL_PASSWORD="${DRUPAL_PASSWORD:-admin}"
DRUPAL_LOGIN_URL="${DRUPAL_LOGIN_URL:-http://web/user/login}"

DRUPAL_DATABASE_HOST="${DRUPAL_DATABASE_HOST:-db}"
DRUPAL_DATABASE_USER="${DRUPAL_DATABASE_USER:-drupal}"
DRUPAL_DATABASE_PASSWORD="${DRUPAL_DATABASE_PASSWORD:-drupal}"
DRUPAL_DATABASE_NAME="${DRUPAL_DATABASE_NAME:-drupal}"

TEMPFILE="$(mktemp)"

echo "Login to Drupal"
curl \
    --cookie-jar "${TEMPFILE}" \
    --silent \
    -X POST \
    -F "name=${DRUPAL_USERNAME}" \
    -F "pass=${DRUPAL_PASSWORD}" \
    -F "form_id=user_login" \
    -F "op=Log in" \
    "${DRUPAL_LOGIN_URL}" 1>/dev/null

echo "Submit CiviCRM install request"
curl \
    --cookie "${TEMPFILE}" \
    --silent \
    -X POST \
    -F "mysql[server]=${CIVICRM_DATABASE_HOST}" \
    -F "mysql[username]=${CIVICRM_DATABASE_USER}" \
    -F "mysql[password]=${CIVICRM_DATABASE_PASSWORD}" \
    -F "mysql[database]=${CIVICRM_DATABASE_NAME}" \
    -F "drupal[server]=${DRUPAL_DATABASE_HOST}" \
    -F "drupal[username]=${DRUPAL_DATABASE_USER}" \
    -F "drupal[password]=${DRUPAL_DATABASE_PASSWORD}" \
    -F "drupal[database]=${DRUPAL_DATABASE_NAME}" \
    -F "go=1" \
    -F "seedLanguage=en_US" \
    -F "loadGenerated=0" \
    "${CIVICRM_INSTALL_URL}" 1>/dev/null

# force_reinstall=1

rm -f "${TEMPFILE}"
