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
- Password management - [1password](https://1password.com/)
- Color Schema - https://github.com/catppuccin/catppuccin (used everywhere)
- Desktop search/launcher
  - [LaunchBar](https://www.obdev.at/products/launchbar/index.html)
  - I think there are [better alternatives](https://www.raycast.com/) but I'm don't see big advantage in change
- VSCode - nothing extra Go plugin for development, maybe mention [FindItFaster](https://marketplace.visualstudio.com/items?itemName=TomRijndorp.find-it-faster) for fzf integration there
- Terminal - currently switch from [iTerm2](https://iterm2.com/) to [WezTerm](https://wezfurlong.org/wezterm/index.html) 
    - WezTerm is multiplatform
    - I like lua for [configuration](./wezterm/wezterm.lua)
    - Should be faster
    - I tried Warp that doesn't work for me, problem with my prompt and another strange behavior
- Window manager - https://magnet.crowdcafe.com/
  - I was thinking about [yabai](https://github.com/koekeishiya/yabai) but doesn't have time to test it
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
  - [ripgrep](https://github.com/BurntSushi/ripgrep) - rg instead [ack](https://linux.die.net/man/1/ack), grep
  - [dog instead dig](https://github.com/ogham/dog) - dig alternative
  - [k9s](https://k9scli.io/) - [color schema](https://github.com/catppuccin/k9s) - ui client for k8s
  - [mc](https://github.com/MidnightCommander/mc) - [color schema](https://github.com/catppuccin/mc) file manager in console
