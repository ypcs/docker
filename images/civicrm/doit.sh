#!/bin/sh
set -e

drush \
    --yes \
    site-install minimal \
    --site-name="mysite" \
    --accout-name="admin" \
    --account-pass="admin"

drush \
    --yes \
    pm-enable \
        admin \
        ctools \
        views \
        views_ui \
        backup_migrate \
        devel \
        memcache \
        memcache_admin
