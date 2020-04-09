#!/bin/sh

set -eu

SESSION="$(tmux list-sessions -F "(#{session_attached}) #S [#{pane_current_command}] #{pane_title}" | sort | dmenu -p "Running TMUX Sessions" | awk '{print $2}')"

case "$SESSION" in
	"")
		;;
	*)
		kitty tmux attach -t "$SESSION"
		;;
esac

