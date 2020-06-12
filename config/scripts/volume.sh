#!/bin/sh

set -eu

CURR_VOL="$(pactl list sinks | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | tail -n1)"
MAX_VOL=150

case "$1" in
	-u)
		NEW_VOL=$((CURR_VOL+5))
		[ "${NEW_VOL}" -gt "${MAX_VOL}" ] && NEW_VOL="${MAX_VOL}"
		;;
	-d)
		NEW_VOL=$((CURR_VOL-5))
		[ "${NEW_VOL}" -lt 0 ] && NEW_VOL=0
		;;
	*)
		NEW_VOL="${CURR_VOL}"
		;;
esac

pactl set-sink-volume @DEFAULT_SINK@ "${NEW_VOL}%"
if [ "${NEW_VOL}" -le 0 ]; then
	pactl set-sink-mute @DEFAULT_SINK@ 1
else
	pactl set-sink-mute @DEFAULT_SINK@ 0
fi
