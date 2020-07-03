# update PATH
[ -f "${HOME}/.bash_paths" ] && . "${HOME}/.bash_paths"

# start gnome-keyring
if command -v gnome-keyring-daemon > /dev/null ; then
	eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
	export SSH_AUTH_SOCK
fi

# Source .bashrc if is interactive shell, duh!
[ -f "${HOME}"/.bashrc ] && . "${HOME}"/.bashrc
