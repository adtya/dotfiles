#!/bin/sh
set -eu

SESSION="$(find "${HOME}/Projects" -type f -name '.vimsession' | dmenu -l 8 -p "Saved VIM Sessions")"

alacritty -e tmux new-session vi -S "${SESSION}"
