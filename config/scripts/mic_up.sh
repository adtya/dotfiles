#!/bin/bash
CURR_VOL="$(pactl list sources | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | tail -1)"
if [ $CURR_VOL -lt 100 ] ; then
    pactl set-source-volume alsa_input.pci-0000_00_1f.3.analog-stereo +5%
fi
CURR_VOL="$(pactl list sources | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | tail -1)"
if [ $CURR_VOL -gt 100 ] ; then
    pactl set-source-volume alsa_input.pci-0000_00_1f.3.analog-stereo 100%
fi
