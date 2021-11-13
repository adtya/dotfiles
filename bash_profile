# update PATH
[ -f "${HOME}/.bash_paths" ] && . "${HOME}/.bash_paths"

# Return if non-interactive shell
[[ $- != *i* ]] && return

# Source .bashrc if is interactive shell
[ -f "${HOME}"/.bashrc ] && . "${HOME}"/.bashrc
