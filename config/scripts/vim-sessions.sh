#!/bin/sh
set -eu

SESSION="$(find "${HOME}/Projects" -type f -name '.vimsession' -exec dirname {} \; | dmenu -p "Saved VIM Sessions")"

kitty vi -S "${SESSION}/.vimsession"
