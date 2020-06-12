# Add nodejs from /opt/nodejs
if [ -d "/opt/nodejs/bin" ] && [[ "${PATH}" != */opt/nodejs/bin:* ]] ; then
	export PATH="/opt/nodejs/bin:${PATH}"
fi

# Add yarnpkg from /opt/yarnpkg
if [ -d "/opt/yarnpkg/bin" ] && [[ "${PATH}" != */opt/yarnpkg/bin:* ]] ; then
	export PATH="/opt/yarnpkg/bin:${PATH}"
fi

# Add go from /opt/go
if [ -d "/opt/go/bin" ] && [[ "${PATH}" != */opt/go/bin:* ]] ; then
	export PATH="/opt/go/bin:${PATH}"
	export GOPATH="${HOME}/go"
	export PATH="${GOPATH}/bin:${PATH}"
fi

# Add stuff from /opt/bin
if [ -d "/opt/bin" ] && [[ "${PATH}" != */opt/bin:* ]] ; then
	export PATH="/opt/bin:${PATH}"
fi

# set PATH so it includes the user's npm global bin if it exists
if [ -d "$HOME/.local/share/npm-global/bin" ] && [[ "${PATH}" != *$HOME/.local/share/npm-global/bin:* ]] ; then
	export PATH="$HOME/.local/share/npm-global/bin:${PATH}"
fi

# set PATH so it includes user's private(local) bin if it exists
if [ -d "$HOME/.local/bin" ] && [[ "${PATH}" != *$HOME/.local/bin:* ]] ; then
	export PATH="$HOME/.local/bin:${PATH}"
fi

# set PATH so it includes user's private(home) bin if it exists
if [ -d "$HOME/.bin" ] && [[ "${PATH}" != *$HOME/.bin:* ]] ; then
	export PATH="$HOME/.bin:${PATH}"
fi

# update manpath to include ~/.local/share/man
if [ -d "${HOME}/.local/share/man" ] && [[ "${MANPATH}" != *${HOME}/.local/share/man:* ]] ; then
	export MANPATH="${HOME}/.local/share/man:${MANPATH}"
fi

