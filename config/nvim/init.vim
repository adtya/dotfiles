call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'

call plug#end()

set number
set relativenumber
set noswapfile

let base16colorspace=256
colorscheme base16-nord
hi! Normal ctermbg=NONE
