set number
set nocompatible 
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

