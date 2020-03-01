#!/bin/sh

set -eu

SESSION="$(tmux list-sessions -F "(#{session_attached}) #S #{pane_current_command} #{pane_title}" | sort | dmenu -p "Active TMUX Sessions" | awk '{print $2}')"

case "$SESSION" in
	"")
		notify-send -t 1500 -u low "Canceled"
		;;
	*)
		kitty tmux attach -t "$SESSION"
		;;
esac


