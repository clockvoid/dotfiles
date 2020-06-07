" START: define filetypes ------------------------------------------------

filetype plugin indent on

augroup DefineFileTypes
    autocmd!
    " if pattern include '/', search for full path
    autocmd BufRead,BufNewFile *.Xresources.d/* setlocal filetype=xdefaults
    autocmd BufRead,BufNewFile .xmobarrc setfiletype haskell
    autocmd BufRead,BufNewFile *.hs setlocal filetype=haskell
    autocmd BufRead,BufNewFile *.rb setlocal filetype=ruby
    autocmd BufRead,BufNewFile *.py setlocal filetype=python
    autocmd BufRead,BufNewFile *.ts setlocal filetype=typescript
    autocmd BufRead,BufNewFile *.nvim setlocal filetype=vim
    autocmd BufRead,BufNewFile *.kt setlocal filetype=kotlin
    autocmd BufRead,BufNewFile *.(md, mdwn, mkd, mkdn, mark*) setlocal filetype=markdown
    autocmd BufRead,BufNewFile *Test.php setlocal filetype=phpunit syntax=php
augroup END
" END: define filetypes --------------------------------------------------

" START: settings for filetypes ------------------------------------------
augroup SetFileTypes
    autocmd!
    autocmd filetype cpp setlocal makeprg=g++\ %\ -o\ %<\ -std=c++11
    autocmd filetype c setlocal makeprg=gcc\ %\ -o\ %<
    autocmd filetype java setlocal makeprg=javac\ %
    autocmd filetype haskell let g:haskellmode_completion_ghc = 0
    autocmd filetype haskell setlocal makeprg=ghc\ %\
    autocmd filetype typescript let g:js_indent_typescript = 1
augroup END
" END: settings for filetypes --------------------------------------------

