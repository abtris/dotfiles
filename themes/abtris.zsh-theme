# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
local nvm='%{$fg[yellow]%}‹`nvm_ls 'current'`›%{$reset_color%}'
local npm='%{$fg[yellow]%}‹`npm -v`›%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(vcprompt)%{$reset_color%}'

local git_modules_text=''
if [[ -f .gitmodules ]]; then
  local git_modules='$(grep path .gitmodules | sed "s/.*= //")'
  if [[ -z $git_modules ]]; then
    git_modules_text=""
  else
    git_modules_text="[git:modules: ${git_modules}]"
  fi
fi

PROMPT="╭─${user_host} ${current_dir} ${nvm} ${npm} ${git_branch} ${git_modules_text}
╰─%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
