#!/bin/sh

set -eu
pactl set-sink-volume @DEFAULT_SINK@ -5%
