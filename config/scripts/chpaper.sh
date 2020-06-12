#!/bin/sh

set -eu

DIR="${HOME}/Pictures/Wallpapers"

random_paper() {
	find "${DIR}"/ -type f -regextype egrep -regex ".*\.(jpe?g|png)$" | shuf -n1
}

magick convert "$(random_paper)" -resize 1920x1080^ /tmp/wallpaper.jpg && xwallpaper --zoom /tmp/wallpaper.jpg &
magick convert "$(random_paper)" -resize 1920x1080^ /tmp/lockpaper.png

