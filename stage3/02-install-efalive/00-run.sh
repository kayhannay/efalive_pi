#!/bin/bash -e

install -m 644 files/efalive.list ${ROOTFS_DIR}/etc/apt/sources.list.d/
wget https://efalive.hannay.de/efalive.key -q --show-progress -O files/efalive.gpg.key
cat files/efalive.gpg.key | gpg --dearmor > "${ROOTFS_DIR}/etc/apt/trusted.gpg.d/efalive.gpg"

on_chroot << EOF
apt update
EOF

