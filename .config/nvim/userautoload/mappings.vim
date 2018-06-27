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

" For changing Window separation
nnoremap <Leader>H <C-w>H
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K
nnoremap <Leader>L <C-w>L

" moving window
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" splitting window
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>

" run quickrun
nnoremap <Leader>q :Q<CR>

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
