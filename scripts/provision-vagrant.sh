#!/bin/sh
set -e

adduser \
    --disabled-password \
    --gecos "Vagrant" \
    vagrant

echo "vagrant:vagrant" |chpasswd

echo "vagrant ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/vagrant

apt-get --assume-yes install openssh-server
