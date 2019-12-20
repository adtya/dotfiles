#!/bin/bash
pactl set-sink-mute @DEFAULT_SINK@ 0
CURR_VOL="$(pactl list sinks | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | head -n1)"
if [ $CURR_VOL -lt 110 ] ; then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
fi
CURR_VOL="$(pactl list sinks | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | head -n1)"
if [ $CURR_VOL -gt 110 ] ; then
    pactl set-sink-volume @DEFAULT_SINK@ 110%
fi
