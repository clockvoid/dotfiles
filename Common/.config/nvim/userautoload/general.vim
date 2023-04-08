scriptencoding utf-8
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
set fileformats=unix,dos,mac
lang mes C

" START: basic settings --------------------------------------------------
" about edit files
set background=dark
set tabstop=4
set expandtab
set smarttab
set autoindent
set smartindent
set shiftwidth=4
set ignorecase
set smartcase
syntax on

" about monitor settings
set number
set cmdheight=2
set showcmd
set title
set statusline+=%F

" key stroke settings
set ttimeoutlen=10
" END: basic settings ----------------------------------------------------

" START: command completion ----------------------------------------------
set wildmenu
set wildmode=full
set wildignorecase
" END: commnd completion -------------------------------------------------

" START: settings for terminal -------------------------------------------
tnoremap <silent> <ESC> <C-\><C-n>
" END: settings for terminal ---------------------------------------------

" START: settings for conceal --------------------------------------------
" For conceal markers.
if has('conceal')
    set conceallevel=0
    set concealcursor=""
endif
" END: settings for conceal ----------------------------------------------

" START: settings for color ----------------------------------------------
if !has('gui_runnig')
    set t_Co=256
endif

colorscheme hybrid
highlight LineNr ctermfg=lightgray
set cursorline
highlight CursorLine cterm=none ctermfg=none ctermbg=none guifg=none guibg=none
highlight CursorLineNr ctermfg=white
highlight MatchParen ctermbg=237 ctermfg=255 guibg=#3a3a3a guifg=#eeeeee

let g:lightline = {
            \ 'colorscheme': 'hybrid',
            \ 'separator': {'left': "\ue0b0", 'right': "\ue0b2"},
            \ 'subseparator': {'left': "\ue0b1", 'right': "\ue0b3"}
            \}
" END: settings for color ------------------------------------------------
