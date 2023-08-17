local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.fn['plugin#vim_latex#hook_add']()
vim.fn['plugin#hybrid#hook_add']()

return require('lazy').setup({
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

    {
        'junegunn/fzf',
        build = 'bash ./install --all'
    },
    {
        'junegunn/fzf.vim',
        config = function() vim.fn['plugin#fzf#hook_post_source']() end,
        dependencies = { 'junegunn/fzf' }
    },

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

    {
        'simeji/winresizer',
        config = function() vim.fn['plugin#winresizer#hook_source']() end
    },

    {
        'neovimhaskell/haskell-vim',
        ft = { 'haskell' }
    },

    {
        'scrooloose/syntastic',
        ft = { 'swift' }
    },
    {
        'keith/swift.vim',
        ft = { 'swift' }
    },

    {
        'vim-latex/vim-latex',
        ft = { 'tex' },
        config = function()
            vim.fn['plugin#vim_latex#hook_source']()
        end
    },
})

