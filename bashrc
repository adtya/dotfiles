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

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


export EDITOR=vim
export GPG_TTY=$(tty)

_is_git_dir() {
    if [ -d .git ] || [ "$(git rev-parse --git-dir 2>/dev/null)" ]
    then _GITVAR="git"
    else unset _GITVAR
    fi
}
_get_git_branch() {
    if [ $_GITVAR ]
    then _GITBRANCH="($(git symbolic-ref --quiet --short HEAD 2>/dev/null)) "
    else unset _GITBRANCH
    fi
}

_get_git_dirty() {
    if [ "$_GITVAR" ]
    then {
        if [ -z "$(git status --short 2>/dev/null)" ]
        then {
            _DIRTSYMBOL="\[\033[1;32m\]✔\[\033[0m\] "
        }
        elif [ "$(git ls-files --others --exclude-standard 2>/dev/null)" ]
        then {
            _DIRTSYMBOL="\[\033[1;31m\]✘\[\033[0m\] "
        }
        elif [ "$(git ls-files --exclude-standard 2>/dev/null)" ]
        then {
            _DIRTSYMBOL="\[\033[1;33m\]✘\[\033[0m\] "
        }
        fi
    }
    else {
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

    export PS1=" \[\033[1;31m\]${_ERR}\[\033[0m\]${_DIRTSYMBOL}\[\033[1;33m\]${_VENVNAME}\[\033[0m\]\[\033[1;34m\]\W\[\033[0m\] \[\033[1;32m\]${_GITBRANCH}\[\033[0m\]"
    export PS2=" \[\033[1;35m\]...\[\033[0m\] "
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
