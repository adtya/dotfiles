if command -v tmux > /dev/null ; then
	case "${TERM}" in
		*screen*)
			;;
		*)
			[ -n "${DISPLAY}" ] && [ "x${TERM_PROGRAM}" != "xvscode" ] && [ "x${TERMINAL_EMULATOR}" != "xJetBrains-JediTerm" ] && [ -z "${TMUX}" ] && exec tmux
			;;
	esac
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd extendedglob nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/adtya/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
