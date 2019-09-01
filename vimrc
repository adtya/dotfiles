set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'dracula/vim'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'

call vundle#end()
filetype plugin indent on

set number
set relativenumber
set expandtab
set tabstop=4
set autoindent
set showmatch
set noswapfile

