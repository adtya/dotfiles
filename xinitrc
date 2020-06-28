#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

xrandr --setprovideroutputsource modesetting NVIDIA-0
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
if command -v gnome-keyring-daemon > /dev/null ; then
	eval $(gnome-keyring-daemon --start)
	export SSH_AUTH_SOCK
fi

# start some nice programs
pidof polkit-gnome-authentication-agent-1 || /usr/libexec/polkit-gnome-authentication-agent-1 &
pidof dunst || dunst &
pidof mpd || mpd &
exec dbus-launch --sh-syntax --exit-with-x11 bspwm
