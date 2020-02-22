#!/bin/bash

DIR="${HOME}/Pictures/Wallpapers"

random_paper() {
	/usr/bin/find ${DIR}/ -type f -regextype egrep -regex ".*\.(jpe?g|png)$" | /usr/bin/shuf -n1
}

[ -z "$SWAYSOCK" ] && export SWAYSOCK="$(/usr/bin/find /run/user/${UID}/ -name "sway-ipc.${UID}.*.sock")"
/usr/bin/magick convert "$(random_paper)" /tmp/wallpaper.jpg && /usr/bin/swaymsg "output * bg '/tmp/wallpaper.jpg' fill" &
/usr/bin/magick convert "$(random_paper)" /tmp/lockpaper.jpg
