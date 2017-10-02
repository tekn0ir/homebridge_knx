#!/usr/bin/env bash

{ dbus-daemon ; avahi-daemon ; su -l -c /home/node/node_modules/.bin/homebridge node ; }
