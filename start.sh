#!/usr/bin/env bash

{ dbus-daemon --system --nofork ; avahi-daemon ; su -l -c /home/node/node_modules/.bin/homebridge node ; }
