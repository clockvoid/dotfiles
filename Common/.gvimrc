"
" The gvimrc file is where GUI-specific startup commands should be placed.
" It is always sourced after the vimrc file.
" Color settings are in .vimrc but they are not enable in gvim.
" So, you have to rewrite these settings.
"

" no menu bar, tool bar and scroll bar
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
set guioptions-=m
set guioptions-=F
set guioptions+=a

" for height of gui window on monitor.
set guiheadroom=0

" settings for color
set background=dark
colorscheme hybrid

" setting for font
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Book\ 13

" setting for cursor
set guicursor+=i-ci:block-Cursor/lCursor
