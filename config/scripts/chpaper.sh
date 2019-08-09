#!/bin/bash

DIR="${HOME}/Pictures/Wallpapers"

RANDOM_PAPER="$(/bin/ls ${DIR}/*/* | /usr/bin/shuf -n 1)"
swaymsg "output * bg '${RANDOM_PAPER}' fill"
echo "Wallpaper: ${RANDOM_PAPERi}"
echo "\"${RANDOM_PAPER}\"" > ${HOME}/.cache/wallpaper
