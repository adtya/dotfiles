#!/bin/sh
CURR_VOL="$(pactl list sinks | grep '^\s*Volume' | awk '{print $5}' | sed 's/\%//' | head -n1)"
if [ $CURR_VOL -le 5 ] ; then
	pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo 0
	pactl set-sink-volume bluez_sink.00_1B_C3_07_34_58.a2dp_sink 0
	pactl set-sink-mute alsa_output.pci-0000_00_1f.3.analog-stereo 1
	pactl set-sink-mute bluez_sink.00_1B_C3_07_34_58.a2dp_sink 1
else
	pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo -5%
	pactl set-sink-volume bluez_sink.00_1B_C3_07_34_58.a2dp_sink -5%
fi
