set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'VundleVim/Vundle.vim', {'name': 'vundle'}
Plugin 'dracula/vim', {'name': 'dracula'}
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on

set number
set relativenumber
set expandtab
set autoindent
set showmatch
set noswapfile

"colorscheme dracula
let g:airline_theme='dracula'
"hi Normal ctermbg=None
