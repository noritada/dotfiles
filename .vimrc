" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

call vundle#end()
filetype plugin indent on

" Custom configurations
set encoding=utf-8
set fileencodings=iso-2022-jp,sjis,euc-jp,utf-8

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ENC=%{&fileencoding}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ lines\ %l/%L\ %p%%

au BufRead,BufNewFile *.vcl :set vt=vcl
au! Syntax vcl source ~/.vim/vcl.vim

"set t_Co=256
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm
set incsearch
set hlsearch
syntax on

"colorscheme zenburn

:imap jj <Esc>
