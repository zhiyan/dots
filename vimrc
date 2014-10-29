
" Plugins {{{

let g:plugin_dir = expand('~/.vim/bundle', ':p')
let g:plugin_hash = {}
let g:pathogen_blacklist = []

" Poor man's plugin downloader {{{
if !isdirectory(g:plugin_dir) | call mkdir(g:plugin_dir, "p") | endif

function! DownloadPluginIfMissing(plugin) abort
  let output_dir = g:plugin_dir . '/' . fnamemodify(a:plugin, ":t")
  if isdirectory(output_dir) || !executable('git')
    return
  endif
  let command = printf("git clone -q %s %s", "https://github.com/" . a:plugin . '.git', output_dir)
  echo "DownloadPluginIfMissing: " . command | echo system(command)
  silent! execute 'helptags ' . output_dir . '/doc'
endfunction

function! UpdatePlugin(plugin) abort
  let output_dir = g:plugin_dir . '/' . fnamemodify(a:plugin, ":t")
  if !isdirectory(output_dir) || !executable('git')
    return
  endif
  let command = printf("cd %s && git pull -q", output_dir)
  echo "UpdatePlugin: " . command | echo system(command)
endfunction

function! Pl(...) abort
  for plugin in map(copy(a:000), 'substitute(v:val, ''''''\|"'', "", "g")')
    let g:plugin_hash[ fnamemodify(plugin, ':t') ] = 1
    call DownloadPluginIfMissing(plugin)
  endfor
endfunction

command! -nargs=+ Pl call Pl(<f-args>)
command! -bang -nargs=0 UpdatePlugins if len("<bang>") == 0 | call map( keys(g:plugin_hash), 'UpdatePlugin( v:val )' ) | Helptags | else | execute "Start! vim -c UpdatePlugins -c Helptags -c qa" | endif
" }}}

Pl 'w0ng/vim-hybrid'
Pl 'jonathanfilip/vim-lucius'
Pl 'jnurmine/Zenburn'
Pl 'vim-scripts/jellybeans.vim'
Pl 'vim-scripts/wombat256.vim'
Pl 'junegunn/seoul256.vim'

Pl 'tpope/vim-sensible'  'tpope/vim-commentary' 'tpope/vim-eunuch'
Pl 'tpope/vim-obsession' 'tpope/vim-tbone'      'tpope/vim-unimpaired'
Pl 'tpope/vim-git'       'tpope/vim-markdown'   'tpope/vim-fugitive'
Pl 'tpope/vim-dispatch'  'tpope/vim-rsi'        'tpope/vim-repeat'
Pl 'tpope/vim-jdaddy'    'tpope/vim-surround'   'tpope/vim-projectionist'
Pl 'tpope/vim-endwise'   'tpope/vim-abolish'

Pl 'edkolev/promptline.vim'
Pl 'jeetsukumaran/vim-filebeagle'
Pl 'vim-scripts/tracwiki'
Pl 'gregsexton/gitv'
Pl 'christoomey/vim-tmux-navigator'
Pl 'michaeljsmith/vim-indent-object'
Pl 'majutsushi/tagbar'
Pl 'vim-scripts/ReplaceWithRegister'
Pl 'moll/vim-bbye'
Pl 'elzr/vim-json'
Pl 'edkolev/tmuxline.vim'
Pl 'mbbill/undotree'
Pl 'junegunn/goyo.vim'
Pl 'junegunn/limelight.vim'
" Pl 'wellle/targets.vim'
Pl 'tommcdo/vim-lion'
Pl 'tommcdo/vim-exchange'
Pl 'junegunn/vader.vim'
Pl 'nelstrom/vim-visual-star-search'
Pl 'AndrewRadev/linediff.vim'
Pl 'pydave/renamer.vim'
Pl 'tpope/vim-scriptease'
Pl 'AndrewRadev/writable_search.vim'
Pl 'AndrewRadev/inline_edit.vim'
" Pl 'vim-scripts/DirDiff.vim'
Pl 'vim-scripts/fish-syntax'
Pl 'junegunn/vim-pseudocl'
Pl 'junegunn/vim-oblique'

set nocompatible
syntax on
filetype plugin indent on
Pl 'tpope/vim-pathogen'
execute "source " . g:plugin_dir . '/vim-pathogen/autoload/pathogen.vim'
let g:pathogen_blacklist = filter(map(split(glob(g:plugin_dir . '/*', 1), "\n"),'fnamemodify(v:val,":t")'), '!has_key(g:plugin_hash, v:val)')
execute pathogen#infect(g:plugin_dir . '/{}')

let mapleader = ","

runtime macros/matchit.vim

" }}}

" Plugin Config {{{

let g:Gitv_DoNotMapCtrlKey = 1

let g:promptline_preset = {
        \'a' : [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
        \'c' : [ promptline#slices#cwd() ],
        \'options': {
          \'left_sections' : [ 'a', 'c' ],
          \'left_only_sections' : [ 'a', 'c' ]}}

let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
      \ 'b'   : '[#S] #h',
      \ 'win' : ['[#I] #W'],
      \ 'cwin': ['[#I] #W'],
      \ 'y'   : '%R'}

let g:rsi_no_meta = 1

let g:oblique#incsearch_highlight_all = 1
let g:oblique#clear_highlight = 0

" }}}

" UI {{{
if has('gui_running')
   set guioptions-=T " no toolbar
   set guioptions-=M " no menu
   set guioptions-=r " no right scrollbar
   set guioptions-=L " no left scrollbar
   set guitablabel=%m\ %t
   set guifont=Droid\ Sans\ Mono\ for\ Powerline:h11

   set gcr=a:blinkon0
else
endif

let g:seoul256_background = 235
let g:seoul256_light_background = 253
colo seoul256

set statusline=\ 
set statusline+=[%n%H%R%W]%*\ 
set statusline+=%f%m\ 
set statusline+=%{fugitive#head()}
set statusline+=%=
set statusline+=%c:%l\ of\ %L\ 

" }}}

" Set's {{{
set formatoptions=
set noshowcmd
set noshowmode
set cursorline
set encoding=utf-8

set smartindent
set noswapfile

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

set scrolloff=25
set sidescrolloff=5

set nowrap
set linebreak

set ignorecase
set smartcase
set diffopt+=vertical
set diffopt+=iwhite
set hidden
set numberwidth=1
set splitbelow splitright
set showmatch
set autowrite
set synmaxcol=500
set completeopt=longest,menuone,preview
set complete=.,b,u,t
set wildmode=list:longest,full
set path=**

if !isdirectory($HOME . '/.vim/undo')
  call mkdir($HOME . '/.vim/undo')
endif
if isdirectory($HOME . '/.vim/undo')
  set undodir=~/.vim/undo
  set undofile
endif

set wildignore+=.hg,.git,.svn
set wildignore+=*.beam
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set showbreak=+++\ 
set fillchars=""

set exrc
set secure
set wrapscan
set lazyredraw

set foldopen-=block

" change cursor in INSERT
let &t_SI = exists('$TMUX') ? "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\" : "\<Esc>]50;CursorShape=1\x7"
let &t_EI = exists('$TMUX') ? "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\" : "\<Esc>]50;CursorShape=0\x7"

" }}}

" Mappings & Commands {{{

vnoremap . :normal .<CR>

map Q gwap
nmap \ g;
map \| g,

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nmap <leader># :%s///ng<CR>
nmap <leader>D :%s///g<CR>

nnoremap <leader>w :vsplit<cr>
nnoremap <cr> :update<cr>
nmap <leader>v :e <c-r>=resolve($MYVIMRC)<CR><CR>
nmap <leader>V :e $MYVIMRC.local<CR>

" jump to tag if one, show list otherwise
nmap <C-]> g<C-]>

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

noremap 0 ^

inoremap <c-]> <c-x><c-]>
inoremap <c-l> <c-x><c-l>

nmap Y y$

nmap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

function! ChompWhitespace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
command! -nargs=0 ChompWhitespace call ChompWhitespace()

command! DiffOrig lefta vnew | setlocal bt=nofile bh=delete noswf | r ++edit # | 0d_ | setlocal noma | diffthis | nnoremap <buffer> q :q<cr>:diffoff<cr> | wincmd p | diffthis

if executable('tidyp')
  command! TidyHTML :%!tidyp -q -i --show-errors 0 --tidy-mark 0 --show-body-only 1
endif

nmap gn :%normal 

" 'entire' text object
onoremap ie :<c-u>normal! ggvG$<cr>
xnoremap ie :<c-u>normal! ggvG$<cr>

" 'next' text object, by https://gist.github.com/AndrewRadev/1171559
onoremap an :<c-u>call <SID>NextTextObject('a')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i')<cr>

function! s:NextTextObject(motion)
  echo
  let c = nr2char(getchar())
  let c = c ==# "b" ? "(" : c
  exe "normal! f".c."v".a:motion.c
endfunction

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

au VimResized * :wincmd =

" source .vimrc on save
augroup vimrc
  au!
  au! bufwritepost *vimrc source $MYVIMRC
  au! bufwritepost *vimrc.local source $MYVIMRC
augroup END

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

augroup diff_update
  au!
  au BufWritePost * if &diff == 1 | diffupdate | endif
augroup END

au BufWinEnter *.md set ft=markdown
au BufWinEnter *.conf set ft=conf

augroup fast_quit
  au!
  au FileType help nnoremap <buffer> q :q<cr>
  au FileType qf nnoremap <buffer> q :q<cr>
  au FileType man nnoremap <buffer> q :q<cr>
  au CmdwinEnter * nnoremap <buffer> q :q<cr>
  au BufReadPost fugitive://* nnoremap <buffer> q :q<cr>
augroup END

" highlight ExtraWhitespace only after entering insert mode
augroup extra_whitespace
   au!
   au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
   au InsertLeave * match ExtraWhitespace /\s\+$/
augroup END

" }}}

" Per-language config {{{
augroup filetype_options
  au!
  au BufReadPost * setlocal path=**
  au FileType perl compiler perl
  au FileType perl
        \ let b:endwise_addition = '}' |
        \ let b:endwise_words = 'if,else,sub,while,for,foreach,unless,elsif' |
        \ let b:endwise_syngroups = 'perlConditional,perlFunction,perlRepeat'
  au FileType perl let b:dispatch = 'perl -wc %'

  au FileType r set commentstring=#%s
  au FileType r
        \ let b:endwise_addition = '}' |
        \ let b:endwise_words = 'function,for' |
        \ let b:endwise_syngroups = 'rType,rRepeat'


  au FileType tracwiki setlocal shiftwidth=2 tabstop=2
  au FileType erlang set commentstring=%\ %s
  au BufReadPost fugitive://* set bufhidden=delete
  au FileType gitcommit setlocal spell
  au BufReadPost *vimrc* setlocal foldmethod=marker
augroup END
" }}}
