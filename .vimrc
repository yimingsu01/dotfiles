filetype on
syntax on
set number
set shiftwidth=4
set tabstop=4
set expandtab
set nowrap
set autoindent
set cindent
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
set colorcolumn=80
