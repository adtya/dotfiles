# update PATH
[ -f "${HOME}/.paths" ] && . "${HOME}/.paths"

export EDITOR=nvim
export _JAVA_AWT_WM_NONREPARENTING=1
eval "export $(/usr/bin/gnome-keyring-daemon)"

if [ "$(tty)" == "/dev/tty1" ] ; then
	exec sway
fi

# Return if non-interactive shell
[[ $- != *i* ]] && return

# Source .bashrc if is interactive shell
[ -f "${HOME}"/.bashrc ] && . "${HOME}"/.bashrc

