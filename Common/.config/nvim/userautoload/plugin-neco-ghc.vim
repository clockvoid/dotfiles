" Disabling haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0

let g:necoghc_enable_detailed_browse = 1

let g:necoghc_use_stack = 1

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
