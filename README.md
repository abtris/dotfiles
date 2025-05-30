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
- [PKM](https://en.wikipedia.org/wiki/Personal_knowledge_management) - [LogSeq](https://logseq.com/)
  - sync over private repo
  - plugins:
    - own fork
      - [logseq-plugin-automatic-url-title](https://github.com/abtris/logseq-plugin-automatic-url-title)
    - Marketplace
      - Diagrams as Code
      - Todo list
      - Journals calendar
      - Markdown table editor
      - Copy Code
      - logseq-mergepages-plugin
      - Bullet Threading
      - Page-tags nad Hierarchy (UI)
      - Banners
      - logseq-datalp-plugin
      - Citation Manger
      - Awesome links
      - Tabs
      - Helium
      - Tags
      - logseq-mermaid-plugin
  - Citations/papers - [Zotero](https://www.zotero.org/) - Your personal research assistant
- Color Schema - https://github.com/catppuccin/catppuccin (used everywhere)
- Desktop search/launcher
  - [LaunchBar](https://www.obdev.at/products/launchbar/index.html)
  - I think there are [better alternatives](https://www.raycast.com/) but I'm don't see big advantage in change
- IDE - [VSCode](https://code.visualstudio.com/) - nothing extra Go plugin for development, maybe mention [FindItFaster](https://marketplace.visualstudio.com/items?itemName=TomRijndorp.find-it-faster) for fzf integration there
- Terminal - [WezTerm](https://wezfurlong.org/wezterm/index.html) and testing [Ghostty](https://ghostty.org/)
    - WezTerm is multiplatform
      - I like lua for [configuration](./wezterm/wezterm.lua)
    - Ghostty is new written in [Zig](https://ziglang.org/) multi-platform terminal from [Mitchell Hashimoto](https://mitchellh.com/ghostty)
- Tmux replacement - [zellij](https://zellij.dev/) - A terminal workspace with batteries included
- Window manager - https://magnet.crowdcafe.com/
  - I was thinking about [yabai](https://github.com/koekeishiya/yabai) but doesn't have time to test it
- Fonts
  - any Nerd fonts - no extra preference
- Shell
  - Still on Zsh using [oh-my-zsh](https://ohmyz.sh/)
  - Is any real benefit using Fish? Maybe go with [nushell](https://www.nushell.sh/) make more sense.
- Prompt
  - switched from custom PS1 config to [Starship](https://starship.rs/), my config [startship.toml](./startship.toml)
  - like great plugin for integration with azure, k8s etc.
- Tools switcher
  - [mise](https://mise.jdx.dev/) former rtx - The front-end to your dev env
    - fix my problem with autoswitch venv for Python similar what working for Ruby using rbenv, nvm etc., this is more universal
- Source code
  - still git [aliases](./bash/aliases) and [config](./git/.gitconfig)
  - I want try anything else but Github killing reasons to switch to something better.
- Utils
  - [lsd instead ls](https://github.com/lsd-rs/lsd) -  [color schema](https://github.com/catppuccin/lsd)
  - [bat instead cat](https://github.com/sharkdp/bat)
  - [fzf](https://github.com/junegunn/fzf) - using with `j()` function that using `find` and `fzf` - [custom rule](./bash/aliases?plain=1#L135)
  - [zoxide](https://github.com/ajeetdsouza/zoxide) - smarter cd command, missing matching settings to fix my needs as I easy done with find, but combined with smart cd
  - [atuin](https://github.com/atuinsh/atuin) - shell history
  - [ripgrep](https://github.com/BurntSushi/ripgrep) - rg instead [ack](https://linux.die.net/man/1/ack), grep
  - [dog instead dig](https://github.com/ogham/dog) - dig alternative
  - [k9s](https://k9scli.io/) - [color schema](https://github.com/catppuccin/k9s) - ui client for k8s
  - [mc](https://github.com/MidnightCommander/mc) - [color schema](https://github.com/catppuccin/mc) file manager in console
  - [delta](https://github.com/dandavison/delta) - A syntax-highlighting pager for git, diff, and grep output
