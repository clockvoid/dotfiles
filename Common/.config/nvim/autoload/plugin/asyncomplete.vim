
function! plugin#asyncomplete#hook_post_source() abort

    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
    imap <c-space> <Plug>(asyncomplete_force_refresh)

    let g:asyncomplete_auto_completeopt = 1
    let g:asyncomplete_min_chars = 1
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    let g:asyncomplete_auto_popup = 1

    call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
                \ 'name': 'zneosnippet',
                \ 'allowlist': ['*'],
                \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
                \ }))

    call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
                \ 'name': 'file',
                \ 'allowlist': ['*'],
                \ 'completor': function('asyncomplete#sources#file#completor')
                \ }))

    au User asyncomplete_setup call asyncomplete#register_source({
                \ 'name': 'look',
                \ 'allowlist': ['text', 'markdown'],
                \ 'completor': function('asyncomplete#sources#look#completor'),
                \ })
endfunction
