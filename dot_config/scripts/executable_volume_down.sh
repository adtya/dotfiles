#!/bin/sh

set -eu

wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
