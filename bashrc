#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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


export EDITOR=vim
export GPG_TTY=$(tty)

# Set _GITVAR if the CWD is inside a git work tree
_is_git_dir() {
    if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]
    then _GITVAR="$(git rev-parse --show-toplevel 2>/dev/null)"
    else unset _GITVAR
    fi
}

# Set _GITBRANCH to the currently checked out branch
_get_git_branch() {
    if [ $_GITVAR ]
    then _GITBRANCH="($(git symbolic-ref --quiet --short HEAD 2>/dev/null)) "
    else unset _GITBRANCH
    fi
}

# Set _DIRTSYMBOL based on how dirty the directory is.
_get_git_dirty() {
    if [ "$_GITVAR" ]
    then {
        # _TEMP stores the current branch.
        _TEMP="$(echo $_GITBRANCH | sed -e 's/(//' -e 's/)//')"

        # Check if remote and local are in sync.
        if [ x"$(git rev-parse $_TEMP 2>/dev/null)" = x"$(git rev-parse remotes/origin/$_TEMP 2>/dev/null)" ]
        then {
            # Green Tick if in sync.
            _DIRTSYMBOL="\[\033[1;32m\]✔\[\033[0m\] "
        }
        else {
            # Yellow tick if out of sync.
            _DIRTSYMBOL="\[\033[1;33m\]✔\[\033[0m\] "
        }
        fi

        # Check if anything is in staging, overwrites the value set by previous if block
        if [ "$(git diff --name-only --cached 2>/dev/null)" ]
        then {
            # Yellow X if anything is in Staging.
            _DIRTSYMBOL="\[\033[1;33m\]✘\[\033[0m\] "
        }
        fi

        # Check if any unstaged changes, overwrites the value set by any previous if blocks.
        if [ "$(git diff --name-only 2>/dev/null)" ] || [ "$(git ls-files --others --exclude-standard $_GITVAR 2>/dev/null)" ]
        then {
            # Red X if unstaged changes.
            _DIRTSYMBOL="\[\033[1;31m\]✘\[\033[0m\] "
        }
        fi
        unset _TEMP
    }
    else {
        # remove _DIRTSYMBOL if not a valid GIT directory
        unset _DIRTSYMBOL
    }
    fi
}

_get_virtual_env_name() {
    if [ "$VIRTUAL_ENV" ]
    then {
        IFS='/' read -a _envdirectory <<< $VIRTUAL_ENV
        _VENVNAME="${_envdirectory[${#_envdirectory[@]}-1]}"
        _VENVNAME="[$_VENVNAME] "
    }
    else {
        unset _VENVNAME
    }
    fi
}

_err_code() {
    _ERR="$?"
    if [ $_ERR -eq 0 ]
    then unset _ERR
    else _ERR="${_ERR} "
    fi
}

_prompt_maker() {
    _err_code
    history -a
    _is_git_dir
    _get_git_branch
    _get_git_dirty
    _get_virtual_env_name

    # 30 - Dark Gray
    # 31 - Red
    # 32 - Light Green
    # 33 - Yellow
    # 34 - Light Blue
    # 35 - Light Purple
    # 36 - Light Cyan
    # 37 - White

    export PS1=" \[\033[1;31m\]${_ERR}\[\033[0m\]${_DIRTSYMBOL}\[\033[1;33m\]${_VENVNAME}\[\033[0m\]\[\033[1;32m\]\W\[\033[0m\] \[\033[1;34m\]${_GITBRANCH}\[\033[0m\]"
    export PS2=" \[\033[1;35m\]...\[\033[0m\] "
    echo -en '\033]2;'$_VENVNAME${PWD/\/home\/$USER/\~} $_GITBRANCH'\007'
    # Unset variable after use
    unset _ERR
    unset _DIRTSYMBOL
    unset _VENVNAME
    unset _GITBRANCH
    unset _GITVAR
}
export PROMPT_COMMAND='_prompt_maker'

# set PATH so it includes user's private(home) bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private(local) bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes the user's npm global bin if it exists
if [ -d "$HOME/.local/share/npm-global/bin" ] ; then
    export PATH="$HOME/.local/share/npm-global/bin:$PATH"
fi

# set PATH so it includes flutter's bin if it exists
if [ -d "/opt/flutter/bin" ] ; then
    export PATH="/opt/flutter/bin:$PATH"
fi

# set ANDROID_HOME if it exists
if [ -d "/opt/android-sdk" ] ; then
    export ANDROID_HOME="/opt/android-sdk"
fi

if [ "$(tty)" == "/dev/tty1" ] ; then
    sway
fi
