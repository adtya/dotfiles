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
    Hibernate)
      exec systemctl hibernate
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
