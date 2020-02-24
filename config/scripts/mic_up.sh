#!/bin/sh

set -eu

pactl set-source-mute @DEFAULT_SOURCE@ 0
CURR_VOL="$(pactl list sources | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | tail -1)"
if [ "$CURR_VOL" -lt 20 ] ; then
    pactl set-source-volume @DEFAULT_SOURCE@ +5%
fi
CURR_VOL="$(pactl list sources | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | tail -1)"
if [ "$CURR_VOL" -gt 20 ] ; then
    pactl set-source-volume @DEFAULT_SOURCE@ 20%
fi
