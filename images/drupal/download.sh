#!/bin/sh
set -e

cd /var/www

drush pm-download \
    --drupal-project-rename=drupal \
    "drupal-${DRUPAL_VERSION}"

cp -R drupal/* html/
rm -rf drupal

