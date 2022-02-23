#!/bin/sh

set -eu

chpower() {
	case "$1" in
		"")
		;;
		Shutdown)
			exec sudo openrc-shutdown -p now
		;;
		Reboot)
			exec sudo openrc-shutdown -r now
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
