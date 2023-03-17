" START: settings for Custom key Bindings
" Custom Key Binding

" Copy/pasting without input "
vmap <C-s>y "+y
vmap <C-s>d "+d
nmap <C-s>p "+p
nmap <C-s>P "+P
vmap <C-s>p "+p
vmap <C-s>P "+P

" For surrounding a word
nnoremap <C-s>" ciw""<Esc>P
nnoremap <C-s>' ciw''<Esc>P
nnoremap <C-s>` ciw``<Esc>P
nnoremap <C-s>( ciw()<Esc>P
nnoremap <C-s>{ ciw{}<Esc>P
nnoremap <C-s>[ ciw[]<Esc>P

" press gj anytime
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

" for continuous paste on visual mode
xnoremap <expr> p 'pgv"'.v:register.'y`>'

" END: settings for Custom key Bindings
