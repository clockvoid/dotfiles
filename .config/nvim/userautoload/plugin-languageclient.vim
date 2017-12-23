
" language server settings
let g:LanugageClient_serverCommands = {
            \ 'typescript': ['node', '~/javascript/javascript-typescript-langserver/lib/langserver-stdio'],
            \ 'javascript': ['node', '~/javascript/javascript-typescript-langserver/lib/langserver-stdio'],
            \}

" completion settings
set completefunc=LanguageClient#complete
