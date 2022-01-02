# update PATH
[ -f "${HOME}/.paths" ] && . "${HOME}/.paths"

# Return if non-interactive shell
[[ $- != *i* ]] && return

# Source .bashrc if is interactive shell
[ -f "${HOME}"/.bashrc ] && . "${HOME}"/.bashrc

export NEOVIDE_MULTIGRID=true
