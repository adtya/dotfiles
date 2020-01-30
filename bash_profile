# update PATH
[ -f "${HOME}/.bash_paths" ] && . "${HOME}/.bash_paths"

# Start ssh ang gpg angents on login
keychain --agents gpg,ssh > /dev/null 2>&1
[ -f "${HOME}"/.keychain/"${HOSTNAME}"-sh ] && \
	. "${HOME}"/.keychain/"${HOSTNAME}"-sh

# Start window manager on login ( if on tty1 )
if [ "$(tty)" == "/dev/tty1" ] ; then
	export MOZ_ENABLE_WAYLAND=1
	export _JAVA_AWT_WM_NONREPARENTING=1
	[ -z "$(pgrep pulseaudio)" ] && pulseaudio --start --log-target=syslog
	exec dbus-launch --sh-syntax --exit-with-session sway
fi

# Source .bashrc if is interactive shell, duh!
[ -f "${HOME}"/.bashrc ] && . "${HOME}"/.bashrc
