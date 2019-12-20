#!/bin/sh
CURR_VOL="$(pactl list sinks | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | head -n1)"
if [ $CURR_VOL -le 5 ] ; then
	pactl set-sink-volume @DEFAULT_SINK@ 0
	pactl set-sink-mute @DEFAULT_SINK@ 1
else
	pactl set-sink-volume @DEFAULT_SINK@ -5%
fi
