#!/bin/sh
set -e

CHROOT="$1"
IMAGE="$2"

usage() {
    echo "usage: $0 <chroot> <image>"
}

if [ ! -d "${CHROOT}" ]
then
    echo "error: chroot doesn't exist: '${CHROOT}'"
    usage
    exit 1
fi
if [ -e "${IMAGE}" ]
then
    echo "error: target already exists: '${IMAGE}'"
    usage
    exit 1
fi


qemu-img create -f raw "${IMAGE}" 50G
/sbin/mkfs.ext4 "${IMAGE}"

FIMAGE="$(realpath "${IMAGE}")"
MPATH="$(realpath $(mktemp -d))"

mount "${FIMAGE}" "${MPATH}"
cd "${CHROOT}"
rsync -avh . "${MPATH}"
cd ..

umount -l "${MPATH}"
rm -rf "${MPATH}"
