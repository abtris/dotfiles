# Read by every zsh, including non-interactive ones that never source .zshrc
# (scripts, `zsh -c`, agent shells). Put GNU make (brew install make) ahead of
# /usr/bin/make. zlogin repeats this because /etc/zprofile's path_helper moves
# system dirs back to the front in login shells.
typeset -U path
path=(/opt/homebrew/opt/make/libexec/gnubin $path)
