### k8s autocompletion https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-zsh/
autoload -Uz compinit
compinit

export PATH=/usr/local/bin:$PATH

export GOPATH=$HOME/go
export DEVTOOLS=~/dev/d-tools
export YARN="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
export GCLI=$HOME/google-cloud-sdk/bin
export BREW=/opt/homebrew/bin:/opt/homebrew/sbin
export PATH=$DEVTOOLS:$BREW:$GCLI:$PATH:$GOPATH/bin

export LC_ALL=en_US.UTF-8

# history size
export HISTFILESIZE=-1
export HISTSIZE=1000000
# https://unix.stackexchange.com/questions/49214/how-to-remove-a-single-line-from-history
export HISTCONTROL=ignorespace

# Pipenv
export LANG="en_US.UTF-8"

# AWS SAM prevent sending telemetry
export SAM_CLI_TELEMETRY=0

alias python='python3'
alias pip='pip3'
alias gs='git status'
alias gm='git checkout master'
alias gp='git pull'
alias ..='cd ..'
alias ...='cd ../..'
alias cm='cd ~/dev/daria/cybermagnolia/cybermagnolia.com'
alias dev='cd ~/dev'
alias ll='ls -la'
alias tf='terraform'
alias profile='code ~/.profile'
alias sshconf='code ~/.ssh/config'
alias venv='source venv/bin/activate'

#### k8s
alias k='kubectl'
alias mk='minikube'
alias kc='cd ~/.kube/configurations'

# autocompletion
source <(kubectl completion zsh)
compdef __start_kubectl k

# google cloud CLI
source ~/google-cloud-sdk/completion.zsh.inc
# source ~/google-cloud-sdk/path.zsh.inc
# enable brew commands
# eval "$(/opt/homebrew/bin/brew shellenv)"

function j() {
  DIR=$(find ~/dev -type d -maxdepth 2 -depth 2 -print | cut -d '/' -f5,6 | fzf -1 -q "$1")
  cd ~/dev/${DIR}
}

# NAS docker
alias rdocker="docker \
  --tlsverify \
  -H=bardiel.nerv:2376 \
  --tlscacert=/Users/dardar/.docker/daemon-certs/ca.pem \
  --tlscert=/Users/dardar/.docker/daemon-certs/server-cert.pem \
  --tlskey=/Users/dardar/.docker/daemon-certs/server-key.pem"
