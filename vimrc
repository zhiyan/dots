let mapleader = ","

" Vundle config {{{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Themes
Bundle 'badwolf'
Bundle 'ironman.vim'
Bundle 'w0ng/vim-hybrid'
Bundle 'jonathanfilip/lucius'
Bundle 'altercation/vim-colors-solarized'

" Plugins
Bundle 'tpope/vim-sensible'

Bundle 'surround.vim'
Bundle 'ctrlp.vim'
Bundle 'repeat.vim'
Bundle 'NrrwRgn'
Bundle 'tpope/vim-commentary'
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-textobj-lastpat'
Bundle 'kana/vim-textobj-entire'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'tpope/vim-abolish'
Bundle 'leshill/vim-json'
Bundle 'tracwiki'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-tbone'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'sjl/gundo.vim'
Bundle 'bogado/file-line'
Bundle 'tpope/vim-dispatch'
Bundle 'bling/vim-airline'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'nelstrom/vim-markdown-folding'
Bundle 'majutsushi/tagbar'

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:tagbar_autoclose = 1

" Bundle 'tpope/vim-scriptease'

if has('gui_running')
  Bundle 'xolox/vim-notes'
endif

filetype plugin indent on
" }}}

" Plugin Config {{{

let g:localvimrc_whitelist = 'dev/.lvimrc'
let g:localvimrc_sandbox = 0

let g:nrrw_rgn_vert = 1
let g:nrrw_rgn_nohl = 1
let g:nrrw_rgn_wdth = 80

let g:ctrlp_max_height = 25
let g:ctrlp_switch_buffer = 2
let g:ctrlp_working_path_mode = 2
let g:ctrlp_open_multiple_files = '0vt'
let g:ctrlp_dotfiles = 1
let g:ctrlp_custom_ignore = 'Img$\|^Images$\|Files$\|\.svn$\|\.jpg$\|\.png$\|\.gif$'
let g:ctrlp_map = '<leader>,'
nmap <leader>t :CtrlPBufTag<CR>
nmap <leader>r :CtrlPMRUFiles<CR>
nmap <leader>f :CtrlP .<CR>
nmap <leader>T :CtrlPTag<CR>
nmap <leader>e :CtrlPBuffer<CR>

vmap <leader>= :Tabularize/=<CR>
vmap <leader>> :Tabularize/=><CR>

nmap <leader>U :GundoToggle<CR>

let g:notes_tab_indents = 0
let g:notes_directories = ['~/.vim/notes']

let g:Gitv_DoNotMapCtrlKey = 1

let g:airline_theme='solarized'
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.paste = ''

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ctrlp#show_adjacent_modes = 0

let g:airline_inactive_collapse=0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#ctrlp#color_template = 'normal'
       
let g:airline_mode_map = {
      \ '__' : '- ',
      \ 'n'  : 'N ',
      \ 'i'  : 'I ',
      \ 'R'  : 'R ',
      \ 'v'  : 'V ',
      \ 'V'  : 'VL',
      \ 'c'  : 'C ',
      \ '' : 'VB',
      \ 's'  : 'S ',
      \ 'S'  : 'SL',
      \ '' : 'SB',
      \ }

function! AirlineInit()
    let g:airline_section_y = airline#section#create_right(['%v', '%l'])
    let g:airline_section_z = airline#section#create_right(['%P', '%L'])
endfunction
autocmd VimEnter * call AirlineInit()

" }}}

" UI {{{
if has('gui_running')
   set guioptions-=T " no toolbar
   set guioptions-=M " no menu
   set guioptions-=r " no right scrollbar
   set guioptions-=L " no left scrollbar
   set guitablabel=%m\ %t
   set guifont=Droid\ Sans\ Mono\ for\ Powerline:h11

   colo solarized
else
   colo solarized
endif

syntax enable
" }}}

" Set's {{{
set noshowmode
set cursorline
set encoding=utf-8

set smartindent
set noswapfile

set shiftwidth=4
set tabstop=4
set expandtab

set scrolloff=25
set sidescrolloff=5

set wildmode=longest:full

set nowrap
set linebreak

set ignorecase
set smartcase

set diffopt+=vertical
set diffopt+=iwhite

set complete-=i
set complete-=t

set hidden
set relativenumber
set splitbelow splitright
set showmatch
set autowrite
set synmaxcol=500
set completeopt=longest,menuone,preview

" disable cursor blink
set gcr=a:blinkon0

" persistent undo history
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

set wildignore+=.hg,.git,.svn
set wildignore+=*.beam
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

" }}}

" Mappings {{{

" use normal regexes
nnoremap / /\v
vnoremap / /\v

cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

nmap <leader># :%s///n<CR> " count matches
nmap <leader>D :%s///g<CR> " delete matches

nnoremap <leader>w :vnew<cr>
nnoremap <leader>s :update<cr>
nnoremap <cr> :update<cr>
nmap <leader>v :vsplit $MYVIMRC<CR>
nmap <leader>V :vsplit $MYVIMRC.local<CR>
nnoremap <leader><space> :noh<cr>

nmap <C-]> g<C-]>  " jump to tag if one, show list otherwise

nnoremap j gj
nnoremap k gk

inoremap # X<BS>#
noremap 0 ^

" file, tag, line completion
inoremap <c-f> <c-x><c-f>
inoremap <c-]> <c-x><c-]>
inoremap <c-l> <c-x><c-l>

nmap Y y$
" }}}

" Auto Commands {{{

" return to same line on reopen, unless diff-ing
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") && !&diff |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" cursorline on active windows only
augroup cline
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

au WinEnter * :set winfixheight
au VimResized * :wincmd =

" source .vimrc on save
autocmd! bufwritepost .vimrc source $MYVIMRC
autocmd! bufwritepost .vimrc.local source $MYVIMRC

augroup vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

augroup tracwiki
    au!
    au FileType tracwiki setlocal shiftwidth=2 tabstop=2
augroup END

autocmd FileType erlang set commentstring=%\ %s

autocmd FileType perl compiler perl

autocmd BufReadPost fugitive://* set bufhidden=delete

" }}}

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

