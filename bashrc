[[ $- != *i* ]] && return

if command -v tmux > /dev/null ; then
	case "${TERM}" in
		*screen*)
		;;
		*)
			[ -n "${DISPLAY}" ] && [ -z "${TERM_PROGRAM}" ] && [ -z "${TMUX}" ] && exec tmux
		;;
	esac
fi

shopt -s histappend
shopt -s checkwinsize
HISTCONTROL=ignoreboth
HISTSIZE=-1
HISTFILESIZE=-1

_is_git_dir() {
	[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ] && \
		echo -n "$(git rev-parse --show-toplevel 2>/dev/null)"
}

_get_git_branch() {
	[ "$(_is_git_dir)" ] && \
		echo -n "($(git symbolic-ref --quiet --short HEAD 2>/dev/null)) "
}

_get_git_dirty() {
	local _GITDIR="$(_is_git_dir)"
	if [ "$_GITDIR" ]; then
	{
		local _TEMP="$(_get_git_branch | sed -e 's/(//' -e 's/)//')"
		if [ x"$(git rev-parse $_TEMP 2>/dev/null)" = x"$(git rev-parse remotes/origin/$_TEMP 2>/dev/null)" ]
		then {
			local _OC='\033[1;32m'
			local _SYM='✔ '
		}
		else {
			local _OC='\033[1;33m'
			local _SYM='✔ '
		}
		fi

		if [ "$(git diff --name-only --cached 2>/dev/null)" ]
		then {
			local _OC='\033[1;33m'
			local _SYM='✘ '
		}
		fi

		if [ "$(git diff --name-only 2>/dev/null)" ] || [ "$(git ls-files --others --exclude-standard "$_GITDIR" 2>/dev/null)" ]
		then {
			local _OC='\033[1;31m'
			local _SYM='✘ '
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

_is_ssh() {
	[ "${SSH_CONNECTION}" ] && echo -n " "
}

# Setup colors
[ -f "${HOME}/.config/scripts/dracula.sh" ] && . "${HOME}/.config/scripts/dracula.sh"

# Setup prompt
PROMPT_COMMAND='history -a; echo -en "\033]2;$(_get_virtual_env_name)${PWD##*/} $(_get_git_branch)\007"'
PS1=" \[\033[1;31m\]\$(_err_code)\[\033[0m\]"
PS1="${PS1}\[\033[1;31m\]\$(_is_ssh)\[\033[0m\]"
PS1="${PS1}\[\033[1;33m\]\$(_get_virtual_env_name)\[\033[0m\]"
PS1="${PS1}\[\033[1;32m\]\W\[\033[0m\] "
PS1="${PS1}\[\033[1;34m\]\$(_get_git_branch)\[\033[0m\]"
PS1="${PS1}\[\$(_get_git_dirty -o)\]\$(_get_git_dirty)\[\$(_get_git_dirty -c)\]"
export PS1
export PS2=" \[\033[1;35m\]...\[\033[0m\] "

# Setup additional bash completion
for file in "${HOME}"/.local/etc/bash_completion.d/* ; do
	[ -r "${file}" ] && . "${file}"
done

# Misc. environment variables
export VIRTUAL_ENV_DISABLE_PROMPT=1
export GPG_TTY=$(tty)

# Setup aliases
[ -f "${HOME}/.bash_aliases" ] && . "${HOME}/.bash_aliases"

# source paths if not on a login shell
shopt -q login_shell || . "${HOME}/.bash_paths"

