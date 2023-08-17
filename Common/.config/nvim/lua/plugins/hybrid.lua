vim.g.hybrid_custom_term_colors = 1

return {
    { 'w0ng/vim-hybrid' },
    { 'cocopon/lightline-hybrid.vim' },
    {
        'itchyny/lightline.vim',
        dependencies = { 'lightline-hybrid.vim' },
        config = function()
            vim.cmd([[
                let g:lightline = {
                    \ 'colorscheme': 'hybrid',
                    \ 'separator': {'left': "\ue0b0", 'right': "\ue0b2"},
                    \ 'subseparator': {'left': "\ue0b1", 'right': "\ue0b3"}
                    \}
            ]])
        end
    },
}
