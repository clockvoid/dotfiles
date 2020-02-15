scriptencoding utf-8
set encoding=utf-8

" START: basic settings --------------------------------------------------
" about edit files
set tabstop=4
set expandtab
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set showmatch
syntax on

" about monitor settings
set number
set laststatus=2
set cmdheight=2
set showcmd
set title
set background=dark
colorscheme hybrid
" END: basic settings ----------------------------------------------------

" START: command completion ----------------------------------------------
set wildmenu
set wildmode=full
" END: commnd completion -------------------------------------------------

" START: settings for filetypes ------------------------------------------
augroup SetFileTypes
	autocmd!
	autocmd filetype cpp setlocal makeprg=g++\ %\ -o\ %<\ -std=c++11
	autocmd filetype c setlocal makeprg=gcc\ %\ -o\ %<
	autocmd filetype java setlocal makeprg=javac\ %
	autocmd filetype haskell let g:haskellmode_completion_ghc = 0
	autocmd filetype typescript let g:js_indent_typescript = 1
augroup END
" END: settings for filetypes --------------------------------------------

" START: settings for conceal --------------------------------------------
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
  let g:tex_conceal='' " disable tex conceal
endif
" END: settings for conceal ----------------------------------------------
