let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1

" <TAB>: completion.
"imap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#mappings#manual_complete()
"function! s:check_back_space() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"endfunction

" <S-TAB>: completion back.
inoremap <expr> <S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" <TAB>: completion.
inoremap <expr> <tab> pumvisible() ? "\<C-n>" :
	\ neosnippet#expandable_or_jumpable() ?
    \    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
