" START: define filetypes ------------------------------------------------
augroup DefineFileTypes
    autocmd!
    autocmd BufRead,BufNewFile .xmobarrc setfiletype haskell
    autocmd BufRead,BufNewFile *.hs setlocal filetype=haskell
    autocmd BufRead,BufNewFile *.rb setlocal filetype=ruby
    autocmd BufRead,BufNewFile *.py setlocal filetype=python
    autocmd BufRead,BufNewFile *.ts setlocal filetype=typescript
    autocmd BufRead,BufNewFile *.nvim setlocal filetype=vim
    autocmd BufRead,BufNewFile *.kt setlocal filetype=kotlin
    autocmd BufRead,BufNewFile *.(md, mdwn, mkd, mkdn, mark*) setlocal filetype=markdown
augroup END
" END: define filetypes --------------------------------------------------

