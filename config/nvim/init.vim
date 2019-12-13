call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'dracula/vim',{'as':'dracula'}

call plug#end()

set number
set relativenumber
set noswapfile

set termguicolors
colorscheme dracula
