#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

keychain --agents gpg 2>/dev/null
. ${HOME}/.keychain/${HOSTNAME}-sh-gpg
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export MOZ_ENABLE_WAYLAND=1
if [ "$(tty)" == "/dev/tty1" ] ; then
    if [ -z "$(pgrep pulseaudio)" ] ; then
        pulseaudio --start --log-target=syslog
    fi
    sway
fi

HISTCONTROL=ignoreboth
HISTSIZE=-1
HISTFILESIZE=-1
shopt -s histappend
shopt -s checkwinsize

# Use Bash Completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Set _GITVAR if the PWD is inside a git work tree
_is_git_dir() {
    if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
        echo -n "$(git rev-parse --show-toplevel 2>/dev/null)"
    else
        echo -n ""
    fi
}

# Set _GITBRANCH to the current out branch
_get_git_branch() {
    if [ "$(_is_git_dir)" ]; then
        echo -n "($(git symbolic-ref --quiet --short HEAD 2>/dev/null)) "
    else
        echo -n ""
    fi
}

_get_git_dirty() {
    local _GITDIR="$(_is_git_dir)"
    if [ "$_GITDIR" ]; then
    {
        local _TEMP="$(echo $(_get_git_branch) | sed -e 's/(//' -e 's/)//')"
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

        if [ "$(git diff --name-only 2>/dev/null)" ] || [ "$(git ls-files --others --exclude-standard $_GITDIR 2>/dev/null)" ]
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
    if [ "$VIRTUAL_ENV" ]; then
        echo -n "[${VIRTUAL_ENV##*/}] "
    else
        echo -n ""
    fi
}

_err_code() {
    _ERR="$?"
    if [ $_ERR -eq 0 ]; then
        echo -n ""
    else
        echo -n "${_ERR} "
    fi
}

PROMPT_COMMAND='history -a; echo -en "\033]2;$(_get_virtual_env_name)${PWD/\/home\/'$USER'/\~} $(_get_git_branch)\007"'
export PS1=" \[\033[1;31m\]\$(_err_code)\[\033[0m\]\[\$(_get_git_dirty -o)\]\$(_get_git_dirty)\[\$(_get_git_dirty -c)\]\[\033[1;33m\]\$(_get_virtual_env_name)\[\033[0m\]\[\033[1;32m\]\W\[\033[0m\] \[\033[1;34m\]\$(_get_git_branch)\[\033[0m\]"
export PS2=" \[\033[1;35m\]...\[\033[0m\] "

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

if [ -f $HOME/.bash_paths ]; then
    . $HOME/.bash_paths
fi

export EDITOR=vim
export GPG_TTY=$(tty)
export VIRTUAL_ENV_DISABLE_PROMPT=1
