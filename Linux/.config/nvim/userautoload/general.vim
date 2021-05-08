scriptencoding utf-8
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
set fileformats=unix,dos,mac
lang mes C

" START: basic settings --------------------------------------------------
" about edit files
set tabstop=4
set expandtab
set smarttab
set autoindent
set smartindent
set shiftwidth=4
set showmatch
set ignorecase
set smartcase
syntax on

" about monitor settings
set number
"set laststatus=2
set cmdheight=2
set showcmd
set title
set statusline+=%F
"set background=dark

" key stroke settings
set ttimeoutlen=10

let g:python3_host_prog=expand('/usr/sbin/python')
let g:python_host_prog=expand('/usr/sbin/python2')
let g:ruby_host_prog=expand('~/.local/share/gem/ruby/3.0.0/bin/neovim-ruby-host')
"let g:node_host_prog=expand('~/.anyenv/envs/nodenv/versions/13.5.0/bin/neovim-node-host')
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
