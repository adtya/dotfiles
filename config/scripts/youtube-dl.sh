#!/bin/sh

set -eu

BOOKMARK_FILE="${HOME}/documents/youtube-bookmarks.txt"

VIDEOID="$(dmenu -l 8 -p "Youtube video ID" < "${BOOKMARK_FILE}" | awk '{print $1}' | sed 's/\[//g;s/\]//g')"

if ! grep "${VIDEOID}" "${BOOKMARK_FILE}" > /dev/null 2>&1 ; then
	TITLE="$(curl -s "https://www.invidio.us/api/v1/videos/${VIDEOID}?fields=title" | awk -F':' '{$1="";print $0}' | sed 's/^\s*\"//g;s/\"\}$//g')"
	echo "[${VIDEOID}] ${TITLE}" >> "${BOOKMARK_FILE}"
fi

mpv "https://www.invidio.us/watch?v=${VIDEOID}"

