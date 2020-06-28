if comamnd -v keychain > /dev/null 2>&1 ; then
	keychain --agents gpg,ssh > /dev/null 2>&1
	[ -f "${HOME}/.keychain/${HOSTNAME}-sh" ] && \
		. "${HOME}/.keychain/${HOSTNAME}-sh" ]
fi
