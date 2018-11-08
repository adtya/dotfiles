[[ -f ~/.Xresources ]] && xrdb ~/.Xresources

export RXVT_SOCKET="/tmp/urxvt-socket"
urxvtd --quiet --opendisplay --fork

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3
