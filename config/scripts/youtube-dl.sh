#!/bin/sh

set -eu

OPTION="$1"


case "${OPTION}" in
	"-p")
		URL="$(dmenu -l 0 -p "URL to play:")"
		if [ -n "${URL}" ] ; then
			notify-send "Fetching video" "${URL}"
			mpv "${URL}"
		else
			notify-send "Fetching failed!" "provided url is empty!"
		fi
		;;
	"-d")
		URL="$(dmenu -l 0 -p "Video to download:")"
		if [ -n "${URL}"  ] ; then
			notify-send "Downloading video" "${URL}"
			VIDEO_DIR="${HOME}/videos"
			youtube-dl "${URL}" -o "${VIDEO_DIR}/youtube-dl/%(title)s_$(id)s.%(ext)s" --restrict-filenames
			notify-send "Download finished" "${URL}"
		else
			notify-send "Fetching failed!" "provided url is empty!"
		fi
		;;
esac
