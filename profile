export NPM_TOKEN=""

export PATH=/usr/local/bin:/usr/local/sbin:~/bin:~/lib:$PATH

export LIBRESSL=/usr/local/opt/libressl/bin
export GOPATH=$HOME/go
export IGOR=$HOME/dev/igor
export DEVTOOLS=~/dev/d-tools

export GT=/usr/local/opt/gettext/bin

export PATH=$GT:$M3:$DEVTOOLS:$LIBRESSL:$PATH:$IGOR:$GOPATH/bin
# gettext
export LDFLAGS="-L/usr/local/opt/gettext/lib"
export CPPFLAGS="-I/usr/local/opt/gettext/include"

export LC_ALL=en_US.UTF-8

# history size
export HISTFILESIZE=1000000
export HISTSIZE=1000000

source ~/.nvm/nvm.sh
alias python='python3'
alias pip='pip3'
alias gs='git status'
alias gm='git checkout master'
alias gp='git pull'
alias ..='cd ..'
alias ...='cd ../..'
alias tf='terraform'
alias profile='code ~/.profile'
alias sshconf='code ~/.ssh/config'
alias venv='source venv/bin/activate'

alias kc='kubectl'
alias mk='minikube'

alias ssh_kill='pkill ssh-agent'
alias ssh_connect='eval $(ssh-agent -s) && ssh-add -s ssh-add -s /usr/local/lib/opensc-pkcs11_hack.so'

source ~/scripts/anvm.sh

function j() {
  DIR=`find ~/dev -type d -maxdepth 2 -depth 2 -print | cut -d '/' -f5,6 | fzf -1 -q "$1"`
  cd ~/dev/${DIR}
}
