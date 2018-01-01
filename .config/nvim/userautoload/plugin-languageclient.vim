
set hidden

" language server settings
let g:LanguageClient_serverCommands = {
            \ 'typescript': ['typescript-language-server', '--stdio'],
            \ 'javascript': ['node', '~/javascript/javascript-typescript-langserver/lib/langserver.js', '--stdio'],
            \ 'rust': ['rustup', 'run', 'stable', 'rls'],
            \ 'haskell': ['hie', '--lsp'],
            \ 'php': ['php', '/home/clock/php/php-language-server/bin/php-language-server.php'],
            \ 'c': ['clangd'],
            \ 'cpp': ['clangd'],
            \}

let g:LanugageClient_autoStart = 1

let g:LanguageClient_diagnosticsDisplay = {
            \ 1: {
            \     'name': 'Error',
            \     'texthl': 'ALEError',
            \     'signText': '✖',
            \     'signTexthl': 'ALEErrorSign',
            \ },
            \ 2: {
            \     'name': 'Warning',
            \     'texthl': 'ALEWarning',
            \     'signText': '⚠',
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
            \     'signText': '➤',
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
