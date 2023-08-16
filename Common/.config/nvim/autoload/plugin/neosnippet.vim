
function! plugin#neosnippet#hook_post_source() abort

    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " pumvisibility checks are in the asyncomplete settings file
    smap <expr> <Tab> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    let g:neosnippet#enable_snipmate_compatibility = 1
endfunction
