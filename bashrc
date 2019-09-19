#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export MOZ_ENABLE_WAYLAND=1
keychain --agents gpg 2>/dev/null
. ${HOME}/.keychain/${HOSTNAME}-sh-gpg
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

if [ "$(tty)" == "/dev/tty1" ] ; then
    if [ -z "$(pgrep pulseaudio)" ] ; then
        pulseaudio --start --log-target=syslog
    fi
    sway
fi

export EDITOR=vim
export GPG_TTY=$(tty)
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=-1
HISTFILESIZE=-1
shopt -s checkwinsize

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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
    if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]
    then echo "$(git rev-parse --show-toplevel 2>/dev/null)"
    else echo ""
    fi
}

# Set _GITBRANCH to the current out branch
_get_git_branch() {
    if [ "$(_is_git_dir)" ]
    then echo "($(git symbolic-ref --quiet --short HEAD 2>/dev/null)) "
    else echo ""
    fi
}

# Set _DIRTSYMBOL based on how dirty the git directory is.
_get_git_dirty() {
    if [ "$(_is_git_dir)" ]
    then {
        # _TEMP stores the current branch.
        _TEMP="$(echo $(_get_git_branch) | sed -e 's/(//' -e 's/)//')"

        # Check if remote and local are in sync.
        if [ x"$(git rev-parse $_TEMP 2>/dev/null)" = x"$(git rev-parse remotes/origin/$_TEMP 2>/dev/null)" ]
        then {
            # Green Tick if in sync.
            _DIRT="gt"
        }
        else {
            # Yellow tick if out of sync.
            _DIRT="yt"
        }
        fi

        # Check if anything is in staging, overwrites the value set by previous if block
        if [ "$(git diff --name-only --cached 2>/dev/null)" ]
        then {
            # Yellow X if anything is in Staging.
            _DIRT="yx"
        }
        fi

        # Check if any unstaged changes, overwrites the value set by any previous if blocks.
        if [ "$(git diff --name-only 2>/dev/null)" ] || [ "$(git ls-files --others --exclude-standard $(_is_git_dir) 2>/dev/null)" ]
        then {
            # Red X if unstaged changes.
            _DIRT="rx"
        }
        fi
        unset _TEMP
    }
    else {
        # remove _DIRT if not a valid GIT directory
        unset _DIRT
    }
    fi
    case "$_DIRT" in
        "gt")
            echo -e "\033[1;32m✔\033[0m "
            ;;
        "yt")
            echo -e "\033[1;33m✔\033[0m "
            ;;
        "yx")
            echo -e "\033[1;33m✘\033[0m "
            ;;
        "rx")
            echo -e "\033[1;31m✘\033[0m "
            ;;
        *)
            echo ""
            ;;
    esac
}

_get_virtual_env_name() {
    if [ "$VIRTUAL_ENV" ]
    then {
        IFS='/' read -a _envdirectory <<< $VIRTUAL_ENV
        _VENVNAME="${_envdirectory[${#_envdirectory[@]}-1]}"
        echo "[$_VENVNAME] "
    }
    else {
        echo ""
    }
    fi
    unset _VENVNAME
}

_err_code() {
    _ERR="$?"
    if [ $_ERR -eq 0 ]
    then echo ""
    else echo "${_ERR} "
    fi
}

prompt_command="history -a; echo -en '\033]2;'$(_get_virtual_env_name)${PWD/\/home\/$USER/\~} $(_get_git_branch)'\007'"

# 30 - Dark Gray
# 31 - Red
# 32 - Light Green
# 33 - Yellow
# 34 - Light Blue
# 35 - Light Purple
# 36 - Light Cyan
# 37 - White

export PS1=' \[\033[1;31m\]$(_err_code)\[\033[0m\]$(_get_git_dirty)\[\033[1;33m\]$(_get_virtual_env_name)\[\033[0m\]\[\033[1;32m\]\W\[\033[0m\] \[\033[1;34m\]$(_get_git_branch)\[\033[0m\]'
export PS2=' \[\033[1;35m\]...\[\033[0m\] '

# set PATH so it includes user's private(home) bin if it exists
if [ -d "$HOME/.bin" ] && [[ "$PATH" != *$HOME/.bin:* ]] ; then
    export PATH="$HOME/.bin:$PATH"
fi

# set PATH so it includes user's private(local) bin if it exists
if [ -d "$HOME/.local/bin" ] && [[ "$PATH" != *$HOME/.local/bin:* ]] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes the user's npm global bin if it exists
if [ -d "$HOME/.local/share/npm-global/bin" ] && [[ "$PATH" != *$HOME/.local/share/npm-global/bin:* ]] ; then
    export PATH="$HOME/.local/share/npm-global/bin:$PATH"
fi

# Add nodejs from /opt/nodejs
if [ -d "/opt/nodejs/bin" ] && [[ "$PATH" != */opt/nodejs/bin:* ]] ; then
    export PATH="/opt/nodejs/bin:$PATH"
fi

# Add yarnpkg from /opt/yarnpkg
if [ -d "/opt/yarnpkg/bin" ] && [[ "$PATH" != */opt/yarnpkg/bin:* ]] ; then
    export PATH="/opt/yarnpkg/bin:$PATH"
fi

if [ -d "/opt/exercism" ] ; then
    source /opt/exercism/shell/exercism_completion.bash
fi

