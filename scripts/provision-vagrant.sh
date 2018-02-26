#!/bin/sh
set -e
TARGET="$1"

[ -z "${TARGET}" ] && echo "missing target!" && exit 1
[ ! -d "${TARGET}" ] && echo "target is not a directory!" && exit 1

chroot "${TARGET}" /usr/local/sbin/docker-upgrade

chroot "${TARGET}" adduser \
    --disabled-password \
    --gecos "Vagrant" \
    vagrant

echo "vagrant:vagrant" |chroot "${TARGET}" chpasswd

mkdir -p "${TARGET}/root/.ssh" "${TARGET}/home/vagrant/.ssh"
cat > "${TARGET}/root/.ssh/authorized_keys" << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOF
cp "${TARGET}/root/.ssh/authorized_keys" "${TARGET}/home/vagrant/.ssh/authorized_keys"

chown -R root:root "${TARGET}/root/.ssh"
chroot "${TARGET}" chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 0700 "${TARGET}/home/vagrant/.ssh" "${TARGET}/root/.ssh"


chroot "${TARGET}" apt-get --assume-yes install openssh-server sudo
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >"${TARGET}/etc/sudoers.d/vagrant"

cat >> "${TARGET}/etc/ssh/sshd_config" << EOF
PasswordAuthentication no
PermitRootLogin without-password
EOF

chroot "${TARGET}" /usr/local/sbin/docker-cleanup
