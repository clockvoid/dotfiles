" START: settings for Custom key Bindings
" Custom Key Binding

" make leader to be space
"let mapleader = "\<C-f>"

" Saving file without input enter
nnoremap <C-f>w :w<CR>

" Copy/pasting without input "
vmap <C-f>y "+y
vmap <C-f>d "+d
nmap <C-f>p "+p
nmap <C-f>P "+P
vmap <C-f>p "+p
vmap <C-f>P "+P

" For changing Window separation
nnoremap <C-f>H <C-w>H
nnoremap <C-f>J <C-w>J
nnoremap <C-f>K <C-w>K
nnoremap <C-f>L <C-w>L

" moving window
nnoremap <C-f>h <C-w>h
nnoremap <C-f>j <C-w>j
nnoremap <C-f>k <C-w>k
nnoremap <C-f>l <C-w>l

" splitting window
nnoremap <C-f>v :vsplit<CR>
nnoremap <C-f>s :split<CR>

" run quickrun
nnoremap <C-f>q :Q<CR>

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
