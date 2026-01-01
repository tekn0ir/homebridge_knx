#!/bin/sh
set -xe

rm -f /var/run/dbus.pid | echo 'PID did not exist---so its fine'

#dbus-daemon --system
avahi-daemon -D
$@
