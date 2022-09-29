" Vundle {{{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Zenburn'
Plugin 'rust-lang/rust.vim'

call vundle#end()
filetype plugin indent on
" }}}
" Colors {{{
set t_Co=256
colors zenburn
" }}}
" UI Layout {{{
set number
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch
" }}}
" Searching {{{
set incsearch
set hlsearch
" }}}
" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10

" space open/closes folds
nnoremap <space> za

set foldmethod=indent
" }}}
" Custom configurations {{{
set encoding=utf-8
set fileencodings=iso-2022-jp,sjis,euc-jp,utf-8

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ENC=%{&fileencoding}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ lines\ %l/%L\ %p%%

au BufRead,BufNewFile *.vcl :set vt=vcl
au! Syntax vcl source ~/.vim/vcl.vim

"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm
syntax on

:imap jj <Esc>
" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0
