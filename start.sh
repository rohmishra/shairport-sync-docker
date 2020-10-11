#!/bin/sh

set -e

rm -rf /var/run/dbus.pid
rm -ff /run/dbus/pid

#mkdir -p /var/run/dbus

dbus-uuidgen --ensure
dbus-daemon --system

pulseaudio --log-level=1 &
/usr/lib/bluetooth/bluetoothd --plugin=a2dp -n &

avahi-daemon --daemonize --no-chroot
./bin/simple-bluetooth-agent.sh &
su-exec shairport-sync shairport-sync $@
