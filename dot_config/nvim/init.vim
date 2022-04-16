call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
Plug 'dart-lang/dart-vim-plugin'
Plug 'pangloss/vim-javascript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
call plug#end()
set number
set relativenumber
set noswapfile
set smartindent
set noexpandtab
set tabstop=2
set shiftwidth=2
set laststatus=2
set noshowmode
set clipboard+=unnamedplus
set wrap
set list
set autowrite
set background=dark
colorscheme dracula
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
			\ '*': ['remove_trailing_lines', 'trim_whitespace'],
			\ 'go': ['gofmt', 'goimports', 'golines'],
			\ 'python': ['autopep8', 'autoflake', 'autoimport', 'isort'],
			\ 'javascript': ['eslint', 'prettier_eslint', 'importjs'],
			\ 'json': ['jq']
			\}
"let g:go_highlight_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_function_calls = 1
"let g:go_highlight_function_operators = 1
"let g:go_highlight_function_extra_types = 1
"let g:go_highlight_function_build_constraints = 1

nmap <C-a> gT
nmap <C-d> gt
nmap <C-h> :noh<Return>
" vim-go
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
autocmd FileType go map <leader>b <Plug>(go-build)
autocmd FileType go map <leader>r <Plug>(go-run)
autocmd FileType go map <leader>f <Plug>(go-def)
autocmd FileType go map <leader>b <Plug>(go-def-pop)

nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt
nmap <leader>0 0gt
nmap <leader>ce :tabnew $MYVIMRC<Return>
nmap <leader>cu :source $MYVIMRC<Return>
