#!/bin/sh

set -eu

SESSION="$(tmux list-sessions -F "(#{session_attached}) #S [#{pane_current_command}] #{pane_title}" | sort | dmenu -l 8 -p "Running TMUX Sessions" | awk '{print $2}')"

case "$SESSION" in
	"")
		;;
	*)
		kitty -e tmux attach -t "$SESSION"
		;;
esac

