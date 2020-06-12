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
		Hibernate)
			echo disk | sudo tee /sys/power/state
		;;
		Logout)
			swaymsg exit
		;;
		*)
			notify-send -t 1500 -u low "Invalid Option"
		;;
	esac
}

OPTIONS="Shutdown\nReboot\nHibernate\nLogout"

chpower "$(printf "%b" "$OPTIONS" | sort | dmenu -p "Power Menu")"
