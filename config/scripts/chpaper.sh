#!/bin/bash

DIR="$HOME/Pictures/Wallpapers"
WALLPAPER="$HOME/.cache/wallpaper.png"

RANDOM_PAPER="$(/bin/ls $DIR/*/* | /usr/bin/shuf -n 1)"
magick convert "${RANDOM_PAPER}" -resize 1920x1080\> "${WALLPAPER}"
swaymsg "output * bg '${WALLPAPER}' fill"
echo "Wallpaper: $RANDOM_PAPER"
