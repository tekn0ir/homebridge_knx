#!/usr/bin/env bash

dbus-daemon --system
avahi-daemon -D
su -l -c /home/node/node_modules/.bin/homebridge node
