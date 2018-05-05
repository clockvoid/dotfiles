
"set hidden

" language server settings
let g:LanguageClient_serverCommands = {
            \ 'typescript': ['node', '~/javascript/javascript-typescript-langserver/lib/language-server-stdio.js'],
            \ 'javascript': ['node', '~/javascript/javascript-typescript-langserver/lib/language-server.js'],
            \ 'rust': ['rustup', 'run', 'stable', 'rls'],
            \ 'php': ['php', '/home/clock/php/php-language-server/bin/php-language-server.php'],
            \ 'phpunit': ['php', '/home/clock/php/php-language-server/bin/php-language-server.php'],
            \ 'c': ['clangd'],
            \ 'cpp': ['clangd'],
            \ 'haskell': ['hie', '--lsp'],
            \ 'python': ['pyls']
            \}

let g:LanugageClient_autoStart = 1

let g:LanguageClient_diagnosticsDisplay = {
            \ 1: {
            \     'name': 'Error',
            \     'texthl': 'ALEError',
            \     'signText': 'e',
            \     'signTexthl': 'ALEErrorSign',
            \ },
            \ 2: {
            \     'name': 'Warning',
            \     'texthl': 'ALEWarning',
            \     'signText': 'w',
            \     'signTexthl': 'ALEWarningSign',
            \ },
            \ 3: {
            \     'name': 'Information',
            \     'texthl': 'ALEInfo',
            \     'signText': 'i',
            \     'signTexthl': 'ALEInfoSign',
            \ },
            \ 4: {
            \     'name': 'Hint',
            \     'texthl': 'ALEInfo',
            \     'signText': 'h',
            \     'signTexthl': 'ALEInfoSign',
            \ },
            \}


" completion settings
"set completefunc=LanguageClient#complete
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> L :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

set completefunc=LanguageClient#complete
let g:LanugageClient_trace = "message"
let g:LanugageClient_windowLogMessageLevel = "Log"
