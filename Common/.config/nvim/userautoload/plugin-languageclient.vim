
set hidden

let g:LanguageClient_settingsPath = "~/.config/nvim/userautoload/settings.json"

" language server settings
let g:LanguageClient_serverCommands = {
            \ 'typescript': ['javascript-typescript-stdio'],
            \ 'javascript': ['typescript-language-server', '--stdio'],
            \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
            \ 'typescript.tsx': ['javascript-typescript-stdio'],
            \ 'vue': ['vls'],
            \ 'rust': ['rustup', 'run', 'stable', 'rls'],
            \ 'php': ['php', '/home/clock/php/php-language-server/bin/php-language-server.php'],
            \ 'phpunit': ['php', '/home/clock/php/php-language-server/bin/php-language-server.php'],
            \ 'c': ['clangd'],
            \ 'cpp': ['clangd'],
            \ 'haskell': ['hie-wrapper', '--lsp'],
            \ 'python': ['pyls'],
            \ 'kotlin': ['/Users/clock/git/kotlin-language-server/server/build/install/server/bin/kotlin-language-server']
            \}

let g:LanguageClient_rootMarkers = {
    \ 'javascript': ['jsconfig.json'],
    \ 'typescript': ['tsconfig.json'],
    \ 'haskell': ['*.cabal', 'stack.yaml']
    \ }

"let g:LanugageClient_autoStart = 1

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
set completefunc=LanguageClient#complete
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> L :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F6> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> cl :sign unplace *<CR>

"set completefunc=LanguageClient#complete
"let g:LanugageClient_trace = "verbose"
"let g:LanugageClient_windowLogMessageLevel = "Warning"
