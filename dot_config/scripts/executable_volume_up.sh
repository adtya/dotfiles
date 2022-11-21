#!/bin/sh

set -eu

wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
[ $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F': ' '{print $2}' | sed 's/\.//') -lt 100 ] && wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
