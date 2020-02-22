#!/bin/bash

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
		*)
			notify-send -t 1500 -u low "Invalid Option"
		;;
esac
}

OPTIONS="Shutdown\nReboot"

chpower "$(echo -e $OPTIONS | rofi -dmenu)"
