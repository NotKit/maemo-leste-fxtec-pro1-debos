#!/bin/sh
ls -la /var/tmp
dpkg -i /var/tmp/prebuilt/*.deb
rm -r /var/tmp/prebuilt

# Fix missing dependencies - isc-dhcp-server in particular
apt install -f -y

rc-update del isc-dhcp-server
rc-update add droid-hal-init sysinit

/usr/lib/droid/droid-user-add.sh || true

apt install -y xinput
# Misidentifies touchscreen, should be easy to fix later, but rely on evdev for now
apt install -y xserver-xorg-input-evdev
apt remove -y xserver-xorg-input-libinput
