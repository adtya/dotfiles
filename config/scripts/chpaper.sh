#!/bin/bash

DIR="${HOME}/Pictures/Wallpapers"

RANDOM_PAPER="$(/bin/ls ${DIR}/*/* | /usr/bin/shuf -n 1)"

random_paper() {
	/usr/bin/find ${DIR}/ -type f -regextype egrep -regex ".*\.(jpe?g|png)$" | /usr/bin/shuf -n1
}

[ -z "$SWAYSOCK" ] && export SWAYSOCK="$(/usr/bin/find /run/user/${UID}/ -name "sway-ipc.${UID}.*.sock")"
/usr/bin/swaymsg "output eDP-1 bg '$(random_paper)' fill"
/usr/bin/swaymsg "output HDMI-A-1 bg '$(random_paper)' fill"
echo "\"$(random_paper)\"" > /tmp/wallpaper
