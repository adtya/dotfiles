#!/bin/sh

set -eu

wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
if [ $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F': ' '{print $2}' | sed 's/\.//') -gt 100 ]; then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
fi
