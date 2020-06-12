#!/bin/sh

set -eu

dmenu -p "Emoji Menu" < "${HOME}/.config/scripts/emojis.txt" | awk '{printf $1}' | xclip -i -selection clipboard

