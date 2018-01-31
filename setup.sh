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

cat > /etc/apt/apt.conf.d/99translations << EOF
Acquire::Languages "none";
EOF

cat > /etc/dpkg/dpkg.cfg.d/99docker << EOF
path-exclude=/usr/share/man/*
path-exclude=/usr/share/doc/*
path-exclude=/usr/share/locale/*
path-exclude=/usr/share/gnome/help/*/*
path-exclude=/usr/share/omf/*/*-*.emf
path-include=/usr/share/locale/locale.alias
path-include=/usr/share/locale/en/*
path-include=/usr/share/locale/en_US.UTF-8/*
path-include=/usr/share/omf/*/*-en.emf
path-include=/usr/share/omf/*/*-en_US.UTF-8.emf
path-include=/usr/share/omf/*/*-C.emf
path-include=/usr/share/locale/languages
path-include=/usr/share/locale/all_languages
path-include=/usr/share/locale/currency/*
path-include=/usr/share/locale/l10n/*
EOF

cat > /usr/local/sbin/docker-upgrade << EOF
#!/bin/sh
set -e

apt-get update
apt-get --assume-yes upgrade
if [ "\${1}" = "full" ]
then
    apt-get --assume-yes dist-upgrade
fi
EOF
chmod +x /usr/local/sbin/docker-upgrade

exec /usr/local/sbin/docker-upgrade full

# cleanup
cat > /usr/local/sbin/docker-cleanup << EOF
#!/bin/sh
set -e
apt-get --assume-yes autoremove
apt-get clean
rm -rf /usr/share/doc/*
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /var/lib/apt/lists/* /var/cache/apt/*.bin /var/cache/apt/archives/*.deb
mkdir -p /var/lib/apt/lists/partial
EOF
chmod +x /usr/local/sbin/docker-cleanup

exec /usr/local/sbin/docker-cleanup

sed -i "s/\/\/.*:3142\//\/\//g" /etc/apt/sources.list
