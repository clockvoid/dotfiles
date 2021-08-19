
function! plugin#asyncomplete#hook_post_source() abort

    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
    imap <c-space> <Plug>(asyncomplete_force_refresh)

    let g:asyncomplete_auto_completeopt = 0
    set completeopt=menuone,noinsert,noselect,preview
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    let g:asyncomplete_auto_popup = 1

    call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
                \ 'name': 'neosnippet',
                \ 'allowlist': ['*'],
                \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
                \ }))
endfunction
