call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

set number
set relativenumber
set noswapfile
set smartindent
set noexpandtab
set tabstop=4
set shiftwidth=4
set laststatus=2
set noshowmode

let g:airline_theme='term'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'
