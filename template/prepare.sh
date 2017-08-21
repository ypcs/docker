#!/bin/sh
set -e

export DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get upgrade

apt-get --no-install-recommends --assume-yes install \
    build-essential # <-- add your packages here

# Do your modifications here

# cleanup
apt-get autoremove --assume-yes
apt-get clean
rm -rf /usr/share/doc/*
rm -rf /usr/share/man/*
rm -rf /var/lib/apt/lists/* /var/cache/apt/*.bin
mkdir -p /var/lib/apt/lists/partial
