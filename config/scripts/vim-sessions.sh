#!/bin/sh
set -eu

SESSION="$(find "${HOME}/projects" -type f -name '.vimsession' | dmenu -l 8 -p "Saved VIM Sessions")"

kitty -e tmux new-session vi -S "${SESSION}"
