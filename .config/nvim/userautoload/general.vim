scriptencoding utf-8
set encoding=utf-8

" START: basic settings --------------------------------------------------
" about edit files
set tabstop=4
set expandtab
set smarttab
set autoindent
set smartindent
set shiftwidth=4
set showmatch
syntax on

" about monitor settings
set number
set laststatus=2
set cmdheight=2
set showcmd
set title
"set background=dark

let g:python3_host_prog='/usr/bin/python3'
let g:python_host_prog='/usr/bin/python2'
" END: basic settings ----------------------------------------------------

" START: command completion ----------------------------------------------
set wildmenu
set wildmode=full
" END: commnd completion -------------------------------------------------

" START: settings for terminal -------------------------------------------
"set shell=\"/bin/zsh\"
tnoremap <silent> <ESC> <C-\><C-n>
" END: settings for terminal ---------------------------------------------

" START: settings for conceal --------------------------------------------
" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
    let g:tex_conceal='' " disable tex conceal
endif
" END: settings for conceal ----------------------------------------------
