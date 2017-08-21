#!/bin/sh
set -e

export DEBIAN_FRONTEND="noninteractive"

# cleanup
rm -f /etc/apt/apt.conf.d/99docker

apt-get autoremove --assume-yes
apt-get clean
rm -rf /usr/share/doc/*
rm -rf /usr/share/man/*
rm -rf /var/lib/apt/lists/* /var/cache/apt/*.bin
mkdir -p /var/lib/apt/lists/partial
