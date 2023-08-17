return {
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'mason-org/mason-registry' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'petertriho/cmp-git' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/vim-vsnip' },

    {
        'dense-analysis/ale',
        config = function()
            vim.cmd([[
            let g:ale_hover_to_floating_preview = 1
            let g:ale_linters = {
                \    'markdown': [],
                \    'tex': ['textlint'],
                \    'javascript': ['eslint'],
                \    'go': ['staticcheck']
                \}
            ]])
        end,
        lazy = true,
    },
}

