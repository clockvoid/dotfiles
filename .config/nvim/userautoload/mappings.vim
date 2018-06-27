" START: settings for Custom key Bindings
" Custom Key Binding

" make leader to be space
let mapleader = "\<Space>"

" Saving file without input enter
nnoremap <Leader>w :w<CR>

" Copy/pasting without input "
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" For Move Window
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L

" For moving tabs
nnoremap K gt
nnoremap J gT

" For surrounding a word
nnoremap <Leader>s" ciw""<Esc>P
nnoremap <Leader>s' ciw''<Esc>P
nnoremap <Leader>s` ciw``<Esc>P
nnoremap <Leader>s( ciw()<Esc>P
nnoremap <Leader>s{ ciw{}<Esc>P
nnoremap <Leader>s[ ciw[]<Esc>P

" For ESC without leaving home position
inoremap <C-f> <Esc>

" END: settings for Custom key Bindings
