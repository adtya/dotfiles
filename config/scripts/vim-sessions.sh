#!/bin/sh
set -eu

SESSION="$(find "${HOME}/Projects" -type f -name '.vimsession' | dmenu -p "Saved VIM Sessions")"

kitty tmux new-session nvim -S "${SESSION}"
