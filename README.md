## Homebridge KNX

This repository contains my setup of Homebridge with KNX plugin and my settings.

## Raspberry Pi Setup
Follow the instructions from [Homebridge Raspberry Pi Guide](https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Raspbian)

## Install knxd

Install packages:
```bash
sudo apt-get install knxd
```

Modify `/etc/knxd.conf` to include:
```bash
KNXD_OPTS=/etc/knxd.ini
```
__remove__ any existing `KNXD_OPTS` line first.

Create `/etc/knxd.ini` from file [knxd.ini](knxd.ini)

Add knxd group access to USB device:
```bash
sudo nano /etc/udev/rules.d/99-knx-usb.rules
```
with content:
```bash
SUBSYSTEM=="usb", ATTR{idVendor}=="16d0", ATTR{idProduct}=="0491", MODE:="0660", GROUP:="knxd"
```

Reload udev rules:
```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

Check that device has correct group:
```bash
ls -l /dev/bus/usb/001/002
```

Restart knxd service:
```bash
sudo systemctl restart knxd
```

Tail following log file to see that knxd starts correctly:
```bash
sudo journalctl -u knxd -f
```

## Install Homebridge KNX Plugin
Install Homebridge KNX plugin either using Homebridge UI or command line:
```bash
sudo npm install -g homebridge-knx
```

Add Homebridge configuration to Homebridge `/var/lib/homebridge/config.json` file from [config.json](config.json)

Add Homebridge KNX plugin configuration and accessories to Homebridge `/var/lib/homebridge/knx_config.json` file from [knx_config.json](knx_config.json)

Restart Homebridge service:
```bash
sudo systemctl restart homebridge
```