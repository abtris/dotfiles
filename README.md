# Dotfiles

My dotfiles for configure zsh and alises for mac

Look at [dotfiles](https://dotfiles.github.io/) to get your inspiration.

All [macOS](https://github.com/mathiasbynens/dotfiles/blob/master/.macos)

## Setup

```
mkdir -p ~/bin
cd ~/bin
git clone https://github.com/abtris/dotfiles.git
cd dotfiles
sh install
```

## I use this

### Hardware

- m1 macbook pro 2021 (work)
- m1 mini (home)

- Apple Mac Keyboard wired with numpad with USB-A (2007 model)  + mouse Logitech MX Anywhere 3 (home)
- Apple Magic Keyboard with Touch ID + Apple Magic TouchPad (work)

### Software

- All trying install via brew and find list [Brewfile](Brewfile)
- Color Schema - https://github.com/catppuccin (used everywhere)
- VSCode - nothing extra Go plugin for development, maybe mention [FindItFaster](https://marketplace.visualstudio.com/items?itemName=TomRijndorp.find-it-faster) for fzf integration there
- Terminal - currently switch from [iTerm2](https://iterm2.com/) to [WezTerm](https://wezfurlong.org/wezterm/index.html) 
    - WezTerm is multiplatform
    - I like lua for [configuration](./wezterm/wezterm.lua)
    - Should be faster
    - I tried Warp that doesn't work for me, problem with my prompt and another strange behavior
- Fonts
  - any Nerd fonts - no extra preference
- Shell
  - Still on Zsh using [oh-my-zsh](https://ohmyz.sh/)
- Prompt
  - switched from custom PS1 config to [Starship](https://starship.rs/), my config [startship.toml](./startship.toml)
- Source code
  - still git [aliases](./bash/aliases) and [config](./git/.gitconfig)
- Utils
  - [exa instead ls](https://the.exa.website/)
  - [bat instead cat](https://github.com/sharkdp/bat)
  - [fzf](https://github.com/junegunn/fzf) + [zoxide](https://github.com/ajeetdsouza/zoxide) - smarter cd command
  - [atuin](https://github.com/atuinsh/atuin) - shell history
