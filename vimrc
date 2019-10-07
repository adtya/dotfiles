set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'VundleVim/Vundle.vim', {'name': 'vundle'}
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'chriskempson/base16-vim'

call vundle#end()
filetype plugin indent on

set number
set relativenumber
set expandtab
set autoindent
set showmatch
set noswapfile

let base16colorspace=256
colorscheme base16-nord
hi Normal ctermbg=None
