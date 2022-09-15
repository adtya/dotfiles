#!/bin/sh

set -eu

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+
if [ $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk -F': ' '{print $2}' | sed 's/\.//') -gt 10 ]; then
  wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 10%
fi
