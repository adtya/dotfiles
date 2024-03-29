#!/bin/sh

set -eu

DIR="${HOME}/Pictures/Wallpapers"

random_paper() {
	find "${DIR}"/ -type f -regextype egrep -regex ".*\.(jpe?g|png)$" | shuf -n1
}

SWAYSOCK="${SWAYSOCK:-""}"
if [ -z "${SWAYSOCK}" ] ; then
	SWAYSOCK="$(find /run/user/"$(id -u)"/ -name "sway-ipc.$(id -u).*.sock")"
	export SWAYSOCK
fi
magick convert "$(random_paper)" /tmp/wallpaper.jpg && swaymsg "output * bg '/tmp/wallpaper.jpg' fill" &
magick convert "$(random_paper)" /tmp/lockpaper.jpg

