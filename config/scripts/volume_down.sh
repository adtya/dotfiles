#!/bin/sh

set -eu

CURR_VOL="$(pactl list sinks | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | tail -n1)"
if [ "$CURR_VOL" -le 5 ] ; then
	pactl set-sink-volume @DEFAULT_SINK@ 0
	pactl set-sink-mute @DEFAULT_SINK@ 1
else
	pactl set-sink-volume @DEFAULT_SINK@ -5%
fi
