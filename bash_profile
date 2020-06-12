# update PATH
[ -f "${HOME}/.bash_paths" ] && . "${HOME}/.bash_paths"

# Start ssh ang gpg angents on login
keychain --agents gpg,ssh > /dev/null 2>&1
[ -f "${HOME}"/.keychain/"${HOSTNAME}"-sh ] && \
	. "${HOME}"/.keychain/"${HOSTNAME}"-sh

# Source .bashrc if is interactive shell, duh!
[ -f "${HOME}"/.bashrc ] && . "${HOME}"/.bashrc
