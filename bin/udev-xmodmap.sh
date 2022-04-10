#!/usr/bin/env bash

# This script is designed to be triggered by a udev rule to rerun xmodmap
# when a keyboard is hotpluged.
#
# Usage:
# * First Identify the USB keyboard:
# * `lsusb -v > devices.log`
# * Search for "Keyboard" in devices.log
# * Find the `idVendor` and `idProduct` e.g.
#    idVendor           0x04d9 Holtek Semiconductor, Inc.
#    idProduct          0x4545 Keyboard [Diatec Majestouch 2 Tenkeyless]
#
# * Then create a udev rule (WITHOUT the 0x hex prefix) to run this script e.g.
# * `sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="04d9", ATTR{idProduct}=="4545", RUN+="/home/raoul/bin/udev-xmodmap.sh"' > /etc/udev/rules.d/90-keyboard.rules`
# * Reload udev rules:
# * `sudo udevadm control --reload`
#
# NOTE this won't work for multi-user systems


set -euo pipefail

# Plugging in the keyboard results in multiple udev events so drop a tmp file
# recording when this script was last run. Check it and don't rerun it again if
# it was within `min_seconds_between_executions`.
min_seconds_between_executions=5
date_file="/tmp/last-udev-xmodmap"
now=$(date +%s)

if [[ -f $date_file ]]; then
  prev_ts=$(cat "$date_file")
else
  prev_ts=0
fi

if ((now - prev_ts <= min_seconds_between_executions)); then
  exit 0
fi

echo "$now" > "$date_file"

# run xmodmap in the background so as not to block udev
do_xmodmap() {
  # xmodmap needs DISPLAY to be set which it isn't because udev runs this script
  # as root outside an X session
  export DISPLAY=:0.0 
  export PRIMARY_USER=$(who | head -n 1 | cut -d " " -f 1)
  export HOME=/home/$PRIMARY_USER
  # This doesn't work reliably without a delay but NOTE if you have swapped 
  # caps in your .Xmodmap and hit caps within a second of plugging in the
  # keyboard you will end up with caps stuck on!!
  sleep 1
  xmodmap $HOME/.Xmodmap
}

do_xmodmap &> "${date_file}.log" &

# vim: ft=bash
