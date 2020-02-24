#!/bin/sh

set -eu

chpower() {
	case "$1" in
		"")
			notify-send -t 1500 -u low "Canceled"
		;;
		Shutdown)
			exec sudo openrc-shutdown -p now
		;;
		Reboot)
			exec sudo openrc-shutdown -r now
		;;
		Hibernate)
			swaylock -f -i /tmp/lockpaper.jpg
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

chpower "$(printf "%b" "$OPTIONS" | dmenu -p "Power Menu")"
