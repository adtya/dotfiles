#!/bin/bash
CURR_VOL="$(pactl list sources | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | tail -1)"
if [ $CURR_VOL -le 5 ] ; then
	pactl set-source-volume @DEFAULT_SOURCE@ 0%
	pactl set-source-mute @DEFAULT_SOURCE@ 1
else
	pactl set-source-volume @DEFAULT_SOURCE@ -5%
fi
