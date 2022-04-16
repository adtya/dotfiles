#!/bin/sh

set -eu

chpower() {
	case "$1" in
		"")
		;;
		Shutdown)
			exec systemctl poweroff
		;;
		Reboot)
			exec systemctl reboot
		;;
		Logout)
			swaymsg exit
		;;
		*)
			notify-send -t 1500 -u low "Invalid Option"
		;;
	esac
}

OPTIONS="Shutdown\nReboot\nLogout"

chpower "$(printf "%b" "$OPTIONS" | sort | dmenu -p "Power Menu")"
