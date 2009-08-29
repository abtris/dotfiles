set nocompatible " Disable Vi compatibility
" ===== Appearance =====
set guioptions-=T        " Hide toolbars
set guioptions-=m        " Hide menu
set guifont=Monospace\ 8 " Use nice font
set number               " Show line numbers

" Highlight traling whitespace
autocmd ColorScheme * highlight TrailingWhitespace ctermbg=red guibg=red
autocmd InsertEnter * match TrailingWhitespace /some nonsense/
autocmd InsertLeave * match TrailingWhitespace /\s\+$/
colorscheme darkblue     " Use nice color scheme
" ===== Behavior =====
let mapleader = "," " Map leader to more reachable key
set confirm         " Show confirmation messages
set wildmenu        " Show autocomplete menu for commands
set tabpagemax=1000 " Set maximum number of pages opened by the -p command line
                     " argument to a sane value
set directory=/tmp  " Set central directory for swap files

" ===== Editing =====
set nowrap       " Disable line wrapping
set textwidth=80 " Set maximum width of text being inserted
set autoindent   " Copy indent from current line when starting a new line
set smartindent  " Do smart autoindenting when staring a new line
set expandtab    " Insert spaces instead of <Tab>
set smarttab     " A <BS> will delete a 'shiftwidth' worth of spaces at the start of the line
set tabstop=2    " Number of spaces that a <Tab> counts for
set shiftwidth=2 " Number of spaces to use for each step of  (auto)indent
" Select just pasted text
nmap gp `[v`]
" ===== Search =====
set hlsearch  " Highlight all matches for the last used search pattern
set incsearch " Display search results incrementally

filetype plugin indent on 
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif 
set backup
set backupdir=~/.vim/backup,.,~/ 
set incsearch 
set wildchar=<Tab>
set wildmenu
set wildmode=longest:full,full 



map <A-1> :b1<CR>
map <A-2> :b2<CR>
map <A-3> :b3<CR>
map <A-4> :b4<CR>
map <A-5> :b5<CR>
map <A-6> :b6<CR>
map <A-7> :b7<CR>
map <A-8> :b8<CR>
map <A-9> :b9<CR>
map <A-0> :b10<CR>
map <C-Tab> :bn<CR>
map <S-C-Tab> :bp<CR>

imap <A-1> <Esc>:b1<CR>
imap <A-2> <Esc>:b2<CR>
imap <A-3> <Esc>:b3<CR>
imap <A-4> <Esc>:b4<CR>
imap <A-5> <Esc>:b5<CR>
imap <A-6> <Esc>:b6<CR>
imap <A-7> <Esc>:b7<CR>
imap <A-8> <Esc>:b8<CR>
imap <A-9> <Esc>:b9<CR>
imap <A-0> <Esc>:b10<CR>
imap <C-Tab> <Esc>:bn<CR>
imap <S-C-Tab> <Esc>:bp<CR> 

