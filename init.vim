syntax on
set nocompatible
set number
set smartcase
set smarttab
set smartindent
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set background=dark
set laststatus=2
set encoding=utf-8
set ttyfast                             " Speed up scrolling in Vim
" From https://www.chrisatmachine.com/Neovim/02-vim-general-settings/
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set pumheight=10                        " Makes popup menu smaller
set ruler              			            " Show the cursor row, column numbers
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=v                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set showtabline=0                       " Never show tabs
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

filetype plugin indent on

" set leader key
"let g:mapleader = "\<Space>"

" more subtle matching brace highlighting
set showmatch 
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

"colo darkblue
hi Keyword ctermfg=darkcyan
hi Constant ctermfg=5*
hi Comment ctermfg=2*
hi Normal ctermbg=none
hi LineNr ctermfg=darkgrey

command! W write

" insert mode movements ctrl-hjkl, alt-o opens new line below
inoremap <M-o> <Esc>o
inoremap <M-O> <Esc>O
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

autocmd BufEnter *.html :setlocal filetype=eruby
autocmd BufEnter *.vue  :setlocal filetype=html

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set shiftwidth=4 |
    \ set softtabstop=4

" Toggle relative line numbers
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction

nnoremap <C-g> :call NumberToggle()<CR>

call plug#begin(stdpath('config')  . '/plugged')

Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-grepper'

call plug#end()

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

"Toggle NERDTree with Ctrl-N
map <C-n> :NERDTreeToggle<CR>

"Show hidden files in NERDTree
let NERDTreeShowHidden=1

"Exclude gitignore items from CtrlP search
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"Use Grepper
nnoremap <leader>ga :Grepper -tool grep<cr>
nnoremap <leader>gb :Grepper -tool grep -buffer<cr>

