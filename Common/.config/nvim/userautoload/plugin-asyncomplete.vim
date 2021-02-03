
inoremap <expr> <Tab>   pumvisible() ? "\<Down>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<Up>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 500

call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
            \ 'name': 'neosnippet',
            \ 'allowlist': ['c', 'cpp', 'tex'],
            \ 'priority': 10,
            \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
            \ }))

call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
            \ 'name': 'omni',
            \ 'allowlist': ['*'],
            \ 'blocklist': ['c', 'cpp', 'html'],
            \ 'priority': 0,
            \ 'completor': function('asyncomplete#sources#omni#completor'),
            \ 'config': {
            \   'show_source_kind': 1
            \ },
            \ }))

