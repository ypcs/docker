#!/bin/sh
set -e

CIVICRM_VERSION="${CIVICRM_VERSION:-4.7.29}"
CIVICRM_SHA256="${CIVICRM_SHA256:-5a6dd2e096ddabe95f73c8f07f9329dc607489170f51ecdc45d2f211a443bdae}"

DOCUMENT_ROOT="${DOCUMENT_ROOT:-/var/www/html}"
DRUPAL_MODULE_DIRECTORY="${DRUPAL_MODULE_DIRECTORY:-${DOCUMENT_ROOT}/sites/all/modules}"

TEMPDIR="$(realpath "$(mktemp -d)")"
cd "${TEMPDIR}"

curl -fSL "https://storage.googleapis.com/civicrm/civicrm-stable/${CIVICRM_VERSION}/civicrm-${CIVICRM_VERSION}-drupal.tar.gz" -o "civicrm.tar.gz"
curl -fSL "https://storage.googleapis.com/civicrm/civicrm-stable/${CIVICRM_VERSION}/civicrm-${CIVICRM_VERSION}-l10n.tar.gz" -o "civicrm-l10n.tar.gz"

echo "${CIVICRM_SHA256} *civicrm.tar.gz" |sha256sum -c -

cd "${DRUPAL_MODULE_DIRECTORY}"
tar xzf "${TEMPDIR}/civicrm.tar.gz"
tar xzf "${TEMPDIR}/civicrm-l10n.tar.gz"

echo "Installed CiviCRM ${CIVICRM_VERSION} to ${DRUPAL_MODULE_DIRECTORY}."

rm -rf "${TEMPDIR}"
