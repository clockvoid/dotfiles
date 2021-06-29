setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal smarttab

if executable('stylish-haskell')
    "autocmd FileType haskell setlocal formatprg=stylish-haskell
    autocmd BufWrite *.hs :%!stylish-haskell
    autocmd FileType haskell let b:autoformat_autoindent=0
endif
