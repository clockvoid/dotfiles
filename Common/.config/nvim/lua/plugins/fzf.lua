local function hook_post_source()
vim.cmd([[
    if has("unix")
        let s:uname = system("uname -s")
        if s:uname == "Darwin"
            rtp += /usr/local/opt/fzf
        endif
    endif

    let g:fzf_action = {
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vsplit' }

    let g:fzf_layout = { 'down': '~30%' }

    let g:fzf_colors = {
                \ 'fg':      ['fg', 'Normal'],
                \ 'bg':      ['bg', 'Normal'],
                \ 'hl':      ['fg', 'Comment'],
                \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                \ 'hl+':     ['fg', 'Statement'],
                \ 'info':    ['fg', 'PreProc'],
                \ 'border':  ['fg', 'Ignore'],
                \ 'prompt':  ['fg', 'Conditional'],
                \ 'pointer': ['fg', 'Exception'],
                \ 'marker':  ['fg', 'Keyword'],
                \ 'spinner': ['fg', 'Label'],
                \ 'header':  ['fg', 'Comment'] }

    let g:fzf_history_dir = '~/.local/share/fzf-history'

    nnoremap <C-f> :Files<cr>
    nnoremap <C-b> :Buffers<cr>
]])
end

return {
    {
        'junegunn/fzf',
        build = 'bash ./install --all'
    },
    {
        'junegunn/fzf.vim',
        config = hook_post_source(),
        dependencies = { 'junegunn/fzf' }
    },
}
