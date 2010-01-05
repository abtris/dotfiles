set nocompatible " Disable Vi compatibility
" ===== Appearance =====
set guioptions-=T        " Hide toolbars
set guioptions-=m        " Hide menu
set guifont=Monospace\ 12 " Use nice font
set guiheadroom=0 
set guioptions-=M
set cursorline cursorcolumn " Cursor highlight
set number               " Show line numbers
" Highlight long lines
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.*/

" Highlight traling whitespace
autocmd ColorScheme * highlight TrailingWhitespace ctermbg=red guibg=red
autocmd InsertEnter * match TrailingWhitespace /some nonsense/
autocmd InsertLeave * match TrailingWhitespace /\s\+$/
colorscheme desert256     " Use nice color scheme
" ===== Behavior =====
let mapleader = "," " Map leader to more reachable key
set confirm         " Show confirmation messages
set wildmenu        " Show autocomplete menu for commands
set tabpagemax=1000 " Set maximum number of pages opened by the -p command line
                     " argument to a sane value
set directory=/tmp  " Set central directory for swap files


set t_Co=256

" ===== Editing =====
"set nowrap       " Disable line wrapping
set textwidth=80 " Set maximum width of text being inserted
set autoindent   " Copy indent from current line when starting a new line
set smartindent  " Do smart autoindenting when staring a new line
set expandtab    " Insert spaces instead of <Tab>
set smarttab     " A <BS> will delete a 'shiftwidth' worth of spaces at the start of the line
set tabstop=4    " Number of spaces that a <Tab> counts for
set shiftwidth=4 " Number of spaces to use for each step of  (auto)indent
" === From satrapa http://www.kit.tul.cz/~satrapa/docs/vim/konfig.htm
"set exrc
set history=1000
set backspace=2
set nojoinspaces
set ruler
set showcmd
set showmatch
"set background=dark
" Select just pasted text
nmap gp `[v`]
" ===== Search =====
set hlsearch  " Highlight all matches for the last used search pattern
set incsearch " Display search results incrementally

" == PHP man pages 
" pear install doc.php.net/pman
set keywordprg=pman

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


filetype plugin on
au FileType php set omnifunc=phpcomplete#CompletePHP

" You might also find this useful
" PHP Generated Code Highlights (HTML & SQL)

let php_sql_query=1
let php_htmlInStrings=1



let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1

" run file with PHP CLI (CTRL-M)
:autocmd FileType php noremap <C-M> :w!<CR>:!$HOME/bin/php %<CR>
"
" " PHP parser check (CTRL-L)
:autocmd FileType php noremap <C-L> :!$HOME/bin/php -l %<CR>
