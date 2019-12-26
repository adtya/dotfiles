[[ $- != *i* ]] && return

shopt -s histappend
shopt -s checkwinsize
HISTCONTROL=ignoreboth
HISTSIZE=-1
HISTFILESIZE=-1
export VIRTUAL_ENV_DISABLE_PROMPT=1
export GPG_TTY=$(tty)

_is_git_dir() {
	if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
		echo -n "$(git rev-parse --show-toplevel 2>/dev/null)"
	fi
}

_get_git_branch() {
	if [ "$(_is_git_dir)" ]; then
		echo -n "($(git symbolic-ref --quiet --short HEAD 2>/dev/null)) "
	fi
}

_get_git_dirty() {
	local _GITDIR="$(_is_git_dir)"
	if [ "$_GITDIR" ]; then
	{
		local _TEMP="$(_get_git_branch | sed -e 's/(//' -e 's/)//')"
		if [ x"$(git rev-parse $_TEMP 2>/dev/null)" = x"$(git rev-parse remotes/origin/$_TEMP 2>/dev/null)" ]
		then {
			local _OC='\033[1;32m'
			local _SYM=' '
		}
		else {
			local _OC='\033[1;33m'
			local _SYM=' '
		}
		fi

		if [ "$(git diff --name-only --cached 2>/dev/null)" ]
		then {
			local _OC='\033[1;33m'
			local _SYM=' '
		}
		fi

		if [ "$(git diff --name-only 2>/dev/null)" ] || [ "$(git ls-files --others --exclude-standard "$_GITDIR" 2>/dev/null)" ]
		then {
			local _OC='\033[1;31m'
			local _SYM=' '
		}
		fi
		local _CC='\033[0m'
		local _ARG="$1"
		case "$_ARG" in
			"-o")
				echo -ne "$_OC"
				;;
			"-c")
				echo -ne "$_CC"
				;;
			*)
				echo -ne "$_SYM"
				;;
		esac
	}
	fi
}

_get_virtual_env_name() {
	[ "${VIRTUAL_ENV}" ] && echo -n "[${VIRTUAL_ENV##*/}] "
}

_err_code() {
	local _ERR="$?"
	[ $_ERR -ne 0 ] && echo -n "${_ERR} "
}

for file in "${HOME}"/.local/etc/bash_completion.d/* ; do
	[ -r "${file}" ] && . "${file}"
done

# Setup colors
[ -f "${HOME}/.config/scripts/base16-dracula.sh" ] && . "${HOME}/.config/scripts/base16-dracula.sh"
#PROMPT_COMMAND='history -a; echo -en "\033]2;$(_get_virtual_env_name)${PWD/\/home\/'$USER'/\~} $(_get_git_branch)\007"'
PROMPT_COMMAND='history -a'
PS1=" \[\033[1;31m\]\$(_err_code)\[\033[0m\]"
PS1="${PS1}\[\033[1;33m\]\$(_get_virtual_env_name)\[\033[0m\]"
PS1="${PS1}\[\033[1;32m\]\W\[\033[0m\] "
PS1="${PS1}\[\033[1;34m\]\$(_get_git_branch)\[\033[0m\]"
PS1="${PS1}\[\$(_get_git_dirty -o)\]\$(_get_git_dirty)\[\$(_get_git_dirty -c)\]"
export PS1
export PS2=" \[\033[1;35m\]...\[\033[0m\] "

[ -f "${HOME}/.bash_aliases" ] && . "${HOME}/.bash_aliases"
[ -f "${HOME}/.bash_paths" ] && . "${HOME}/.bash_paths"


# Start WM and if needed, pulseaudio when in /dev/tty1
if [ "$(tty)" == "/dev/tty1" ] ; then
	export MOZ_ENABLE_WAYLAND=1
	export _JAVA_AWT_WM_NONREPARENTING=1
	export SWAY_CURSOR_THEME=Bibata-Classic
	#export XDG_CURRENT_DESKTOP=Unity
	[ -z "$(pgrep pulseaudio)" ] && pulseaudio --start --log-target=syslog
	exec dbus-launch --sh-syntax --exit-with-session sway
fi

# Setup gpg and ssh agents
keychain --agents gpg,ssh 2>/dev/null
. "${HOME}"/.keychain/"${HOSTNAME}"-sh
. "${HOME}"/.keychain/"${HOSTNAME}"-sh-gpg

# Start tmux
if command -v tmux > /dev/null ; then
	case $TERM in
		*screen*)
	;;
		*)
			[ -z $TMUX ] && exec tmux
	;;
	esac
fi

