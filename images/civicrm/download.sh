#!/bin/sh
set -e

cd /var/www/html/sites/all/modules

curl -fSL "https://storage.googleapis.com/civicrm/civicrm-stable/${CIVICRM_VERSION}/civicrm-${CIVICRM_VERSION}-drupal.tar.gz" -o "civicrm.tar.gz"

echo "${CIVICRM_SHA256} *civicrm.tar.gz" |sha256sum -c -
curl -fSL "https://storage.googleapis.com/civicrm/civicrm-stable/${CIVICRM_VERSION}/civicrm-${CIVICRM_VERSION}-l10n.tar.gz" -o "civicrm-l10n.tar.gz"

echo "${CIVICRM_L10N_SHA256} *civicrm-l10n.tar.gz" |sha256sum -c -
tar xzf civicrm.tar.gz && \
tar xzf civicrm-l10n.tar.gz && \

rm -f civicrm.tar.gz civicrm-l10n.tar.gz

