#!/bin/sh

set -eu

SESSION="$(tmux list-sessions -F "(#{session_attached}) #S #{pane_current_command} #{pane_title}" | awk '$1 == "(0)" {print}' | dmenu -p "TMUX sessions" | awk '{print $2}')"

case "$SESSION" in
	"")
		notify-send -t 1500 -u low "Canceled"
		;;
	*)
		kitty tmux attach -t "$SESSION"
		;;
esac


