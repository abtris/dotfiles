. ~/bin/dotfiles/bash/env
. ~/bin/dotfiles/bash/config
. ~/bin/dotfiles/bash/aliases
. ~/bin/dotfiles/zf/zf.bash
. ~/bin/dotfiles/ruby/completion-ruby-all

export ARCHFLAGS="-arch x86_64"

# added by travis gem
[ -f /Users/abtris/.travis/travis.sh ] && source /Users/abtris/.travis/travis.sh

export NVM_DIR="/Users/abtris/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
