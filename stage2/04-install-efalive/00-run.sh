#!/bin/bash -e

#install -m 755 files/resize2fs_once	"${ROOTFS_DIR}/etc/init.d/"

#install -d				"${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d"
#install -m 644 files/ttyoutput.conf	"${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d/"

install -m 644 files/efalive.list ${ROOTFS_DIR}/etc/apt/sources.list.d/
wget https://efalive.hannay.de/efalive.key -q --show-progress -O files/efalive.gpg.key
cat files/efalive.gpg.key | gpg --dearmor > "${ROOTFS_DIR}/etc/apt/trusted.gpg.d/efalive.gpg"

on_chroot << EOF
apt update
EOF

