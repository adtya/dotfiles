#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

xrandr --auto

# merge in defaults and keymaps
if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# some env. variables
export _JAVA_AWT_WM_NONREPARENTING=1

# GTK file picker for Qt apps
export QT_QPA_PLATFORMTHEME=gtk3

# DBus
if command -v dbus-launch > /dev/null ; then
	eval $(dbus-launch --sh-syntax --exit-with-x11)
fi

# Start gnome keyring
if command -v gnome-keyring-daemon > /dev/null ; then
	eval $(gnome-keyring-daemon --start)
	export SSH_AUTH_SOCK
fi

# start some nice programs
exec bspwm
