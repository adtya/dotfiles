#!/bin/sh

set -eu

BRIGHTNESS_DIR="/sys/class/backlight/intel_backlight"
MAX_BRIGHTNESS=$(cat ${BRIGHTNESS_DIR}/max_brightness)
CURR_BRIGHTNESS="$(cat ${BRIGHTNESS_DIR}/brightness)"

case "$1" in
	-u)
		NEW_BRIGHTNESS=$((CURR_BRIGHTNESS+47)) # 47 is 5% of max_brightness :shrug:
		[ "${NEW_BRIGHTNESS}" -gt "${MAX_BRIGHTNESS}" ] && \
			NEW_BRIGHTNESS="${MAX_BRIGHTNESS}"
		;;
	-d)
		NEW_BRIGHTNESS=$((CURR_BRIGHTNESS-47))
		[ "${NEW_BRIGHTNESS}" -lt 0 ] && NEW_BRIGHTNESS=0
		;;
	*)
		NEW_BRIGHTNESS=$CURR_BRIGHTNESS
		;;
esac

echo "${NEW_BRIGHTNESS}" > "${BRIGHTNESS_DIR}/brightness"

