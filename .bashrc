#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=-1
HISTFILESIZE=-1
HISTCONTROL=ignoreboth

BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
PURPLE="$(tput setaf 5)"
RESET="$(tput sgr0)"

alias ls='ls --color=auto --human-readable'
alias l='ls -lah --color=auto'
alias vi='vim'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias ln='ln -v'
alias pacman='sudo pacman'
alias please='sudo'

_is_git_dir() {
    if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
    then GITVAR="git"
    else unset GITVAR
    fi
}
_get_git_branch() {
    if [ $GITVAR ]
    then GITBRANCH="($(git symbolic-ref --quiet --short HEAD 2>/dev/null)) "
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

    export PS1=" \[${BOLD}${DIRT}\]$DIRTSYMBOL\[${RED}\]${ERR}\[${GREEN}\]\W \[${BLUE}\]${GITBRANCH}\[${RESET}\]"
    export PS2=" \[${BOLD}${PURPLE}\]... \[${RESET}\]"
}

export PROMPT_COMMAND='_prompt_maker'

# Environement variables
# set ANDROID_HOME if it exists
if [ -d "/opt/android-sdk" ] ; then
    export ANDROID_HOME="/opt/android-sdk"
fi

# set GPG to prompt for passpharse one current tty
export GPT_TTY=$(tty)

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

