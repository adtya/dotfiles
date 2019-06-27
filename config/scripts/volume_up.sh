#!/bin/bash
CURR_VOL="$(pactl list sinks | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//')"
if [ $CURR_VOL -lt 100 ] ; then
    pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo +5%
fi
CURR_VOL="$(pactl list sinks | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//')"
if [ $CURR_VOL -gt 100 ] ; then
    pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo 100%
fi
