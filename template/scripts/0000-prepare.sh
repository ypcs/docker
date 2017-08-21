#!/bin/sh
set -e

export DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get upgrade

cat > /etc/apt/apt.conf.d/99docker << EOF
APT::Install-Recommends "false";
APT::Get::AutomaticRemove "true";
EOF
