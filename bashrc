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

BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
PURPLE="$(tput setaf 5)"
RESET="$(tput sgr0)"

export EDITOR=vim
export GPG_TTY=$(tty)

_is_git_dir() {
    if [ -d .git ] || [ "$(git rev-parse --git-dir 2>/dev/null)" ]
    then GITVAR="git"
    else unset GITVAR
    fi
}
_get_git_branch() {
    if [ $GITVAR ]
    then GITBRANCH="($(git symbolic-ref --quiet --short HEAD 2>/dev/null)) "
    else unset GITBRANCH
    fi
}

_get_git_dirty() {
    if [ "$GITVAR" ]
    then {
        if [ -z "$(git status --short 2>/dev/null)" ]
        then {
            DIRT="$(tput setaf 2)"
            DIRTSYMBOL="✔ "
        }
        elif [ "$(git ls-files --others --exclude-standard 2>/dev/null)" ]
        then {
            DIRT="$(tput setaf 1)"
            DIRTSYMBOL="✘ "
        }
        elif [ "$(git ls-files --exclude-standard 2>/dev/null)" ]
        then {
            DIRT="$(tput setaf 3)"
            DIRTSYMBOL="✘ "
        }
        fi
    }
    else {
        unset DIRT
        unset DIRTSYMBOL
    }
    fi
}

_get_virtual_env_name() {
    if [ "$VIRTUAL_ENV" ]
    then {
        IFS='/' read -a _envdirectory <<< $VIRTUAL_ENV
        VENV_NAME="${_envdirectory[${#_envdirectory[@]}-1]}"
        VENV_NAME="[$VENV_NAME] "
    }
    else {
        unset VENV_NAME
    }
    fi
}

_err_code() {
    ERR="$?"
    if [ $ERR -eq 0 ]
    then unset ERR
    else ERR="${ERR} "
    fi
}

_prompt_maker() {
    _err_code
    history -a
    _is_git_dir
    _get_git_branch
    _get_git_dirty
    _get_virtual_env_name

    export PS1=" \[${BOLD}${RED}\]${ERR}\[${DIRT}\]${DIRTSYMBOL}\[${YELLOW}\]${VENV_NAME}\[${GREEN}\]\W \[${BLUE}\]${GITBRANCH}\[${RESET}\]"
    export PS2=" \[${BOLD}${PURPLE}\]... \[${RESET}\]"
    echo -en "\033]0; "Terminal" \a"
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

# set PATH so it includes dart-sdk's bin if it exists
if [ -d "/opt/dart-sdk/bin" ] ; then
    export PATH="/opt/dart-sdk/bin:$PATH"
fi

# set PATH so it includes flutter's bin if it exists
if [ -d "/opt/flutter/bin" ] ; then
    export PATH="/opt/flutter/bin:$PATH"
fi

# set ANDROID_HOME if it exists
if [ -d "/opt/android-sdk" ] ; then
    export ANDROID_HOME="/opt/android-sdk"
fi
