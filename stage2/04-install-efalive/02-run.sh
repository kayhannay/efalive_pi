#!/bin/bash -e

#install -m 755 files/resize2fs_once	"${ROOTFS_DIR}/etc/init.d/"

#install -d				"${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d"
#install -m 644 files/ttyoutput.conf	"${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d/"

cp -r files/usr ${ROOTFS_DIR}/
#install -d "${ROOTFS_DIR}/usr/share/plymouth/themes/efa-live"
sed -i 's/^#autologin-user=/autologin-user=efa/g' ${ROOTFS_DIR}/etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=0/autologin-user-timeout=0/g' ${ROOTFS_DIR}/etc/lightdm/lightdm.conf
sed -i 's/^#user-session=default/user-session=efalive-session/g' ${ROOTFS_DIR}/etc/lightdm/lightdm.conf
install -m 644 files/efalive-session.desktop ${ROOTFS_DIR}/usr/share/xsessions/
install -m 755 files/hwclock.service $CHROOT_DIR/etc/systemd/system/
on_chroot << EOF
echo "root:livecd" | chpasswd
ln -s /home/efa/.xinitrc /home/efa/.xsessionrc
/usr/sbin/plymouth-set-default-theme efa-live
usermod -G sudo,plugdev,netdev -a efa
EOF

echo -e "\nhdmi_blanking=1\n\n# RTC settings\n#dtoverlay=i2c-rtc,ds1307\n#dtoverlay=i2c-rtc,ds3231\n" >> ${ROOTFS_DIR}/boot/firmware/config.txt
echo "console=serial0,115200 console=tty1 root=ROOTDEV rootfstype=ext4 fsck.repair=yes rootwait quiet splash logo.nologo plymouth.ignore-serial-consoles init=/usr/lib/raspberrypi-sys-mods/firstboot" > ${ROOTFS_DIR}/boot/cmdline.txt

