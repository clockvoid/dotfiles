
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <f6> <plug>(lsp-rename)
  nmap <buffer> gD <plug>(lsp-type-definition)
  nmap <buffer> L <plug>(lsp-references)
  nmap <buffer> <C-M-b> <plug>(lsp-implementation)
  nmap <buffer> K <plug>(lsp-hover)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_text_edit_enabled = 1
let g:lsp_preview_float = 1
let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']

if executable('haskell-language-server-wrapper')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'haskell-language-server-wrapper',
        \ 'cmd' : {server_info -> ['haskell-language-server-wrapper', '--lsp']},
        \ 'allowlist' : ['haskell'],
        \ })
endif

let g:lsp_settings = {
            \  'hie': {
            \    'disabled': 1,
            \  },
            \  'haskell-language-server': {
            \    'disabled': 1,
            \  },
            \}
let g:lsp_settings['gopls'] = {
            \  'workspace_config': {
            \    'usePlaceholders': v:true,
            \    'analyses': {
            \      'fillstruct': v:true,
            \    },
            \  },
            \  'initialization_options': {
            \    'usePlaceholders': v:true,
            \    'analyses': {
            \      'fillstruct': v:true,
            \    },
            \  },
            \}

" For snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

