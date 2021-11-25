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
set clipboard=unnamedplus               " Copy paste between vim and everything else

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

filetype plugin indent on

" set leader key
" let g:mapleader = "\<Space>"

command! W write
command! Wqa write | quitall
command! Q quit
command! Qa quitall

" insert mode movements ctrl-hjkl, alt-o opens new line below
inoremap <M-o> <Esc>o
inoremap <M-O> <Esc>O
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

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
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'urbit/hoon.vim'
Plug 'mattn/emmet-vim'
Plug 'godlygeek/tabular'

" Plug 'SirVer/ultisnips'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'thomasfaingnaert/vim-lsp-snippets'
" Plug 'thomasfaingnaert/vim-lsp-ultisnips'
Plug 'mattn/vim-lsp-settings'
" Plug 'ervandew/supertab'

call plug#end()

au FileType * set fo-=c fo-=r fo-=o     " Stop newline continution of comments
autocmd BufEnter *.html :setlocal filetype=eruby
autocmd BufEnter *.vue  :setlocal filetype=html

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
nnoremap <leader>ga :Grepper -tool git<cr>
nnoremap <leader>gb :Grepper -tool grep -buffer<cr>
nnoremap <leader>gg :Grepper -tool grep<cr>

let g:user_emmet_leader_key='<C-F>'

" Tabular
nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>
nnoremap <leader>< :Tabularize /<-<CR>
nnoremap <leader>, :Tabularize /,<CR>
nnoremap <leader># :Tabularize /#-}<CR>
nnoremap <leader>: :Tabularize /::<CR>
nnoremap <leader>[ :Tabularize /[<CR>

source $HOME/.config/nvim/themes/onedark.vim

" let g:UltiSnipsExpandTrigger="<TAB>"
" let g:UltiSnipsJumpForwardTrigger="<TAB>"
" let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert

if executable('hoon-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'hoon-language-server',
        \ 'cmd': ['hoon-language-server'],
        \ 'whitelist': ['hoon'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
