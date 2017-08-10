#!/bin/sh
set -e

SUITE="$1"
DEBIAN_MIRROR="$2"

export DEBIAN_FRONTEND="noninteractive"

echo "I: Update sources.list (add security mirror)..."
cat > /etc/apt/sources.list << EOF
deb ${DEBIAN_MIRROR}          ${SUITE}         main
#deb-src ${DEBIAN_MIRROR}          ${SUITE}         main
EOF

if [ "${SUITE}" != "sid" ]
then
cat >> /etc/apt/sources.list << EOF
deb ${DEBIAN_MIRROR}          ${SUITE}-updates main
#deb-src ${DEBIAN_MIRROR}          ${SUITE}-updates main
deb ${DEBIAN_MIRROR}-security ${SUITE}/updates main
#deb-src ${DEBIAN_MIRROR}-security ${SUITE}/updates main
EOF
fi

# Update the system
apt-get update
apt-get upgrade

cat > /tmp/preseed << EOF
localepurge localepurge/mandelete        boolean     true
localepurge localepurge/nopurge          multiselect en, en_US.UTF-8
localepurge localepurge/use-dpkg-feature boolean     false
localepurge localepurge/dontbothernew    boolean     false
EOF
debconf-set-selections < /tmp/preseed
rm -f /tmp/preseed

apt-get -y install localepurge
localepurge

cat > /tmp/preseed << EOF
localepurge localepurge/use-dpkg-feature boolean true
EOF

dpkg-reconfigure localepurge

# cleanup
apt-get clean
rm -rf /var/lib/apt/lists/* /var/cache/apt/*.bin
mkdir -p /var/lib/apt/lists/partial
