# Runs after /etc/zprofile's path_helper, which reorders PATH in login shells.
# Re-prepend GNU make so it wins over /usr/bin/make (see zshenv).
path=(/opt/homebrew/opt/make/libexec/gnubin $path)
