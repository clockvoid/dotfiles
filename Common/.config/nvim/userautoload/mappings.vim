" START: settings for Custom key Bindings
" Custom Key Binding

" make leader to be space
"let mapleader = "\<C-f>"

" Saving file without input enter
nnoremap <C-s>w :w<CR>

" Copy/pasting without input "
vmap <C-s>y "+y
vmap <C-s>d "+d
nmap <C-s>p "+p
nmap <C-s>P "+P
vmap <C-s>p "+p
vmap <C-s>P "+P

" For moving tabs
nnoremap K gt
nnoremap J gT

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

let g:is_us = 1

" for US keyboard
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

function! ToggleKeyset()
    if g:is_us
        nnoremap ; ;
        nnoremap : :
        vnoremap ; ;
        vnoremap : :
        let g:is_us = 0
        echo "JIS keyboard mode"
    else
        nnoremap ; :
        nnoremap : ;
        vnoremap ; :
        vnoremap : ;
        let g:is_us = 1
        echo "US keyboard mode"
    endif
endfunction

noremap <silent> <C-q> :call ToggleKeyset()<CR>

" END: settings for Custom key Bindings
