vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'petertriho/cmp-git'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    use {
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
        cmd = 'ALEEnabe'
    }

    use {
        'junegunn/fzf',
        run = 'bash ./install --all'
    }
    use {
        'junegunn/fzf.vim',
        config = function() vim.fn['plugin#fzf#hook_post_source']() end,
        requires = {'junegunn/fzf'}
    }

    use {
        'w0ng/vim-hybrid',
        config = function() vim.fn['plugin#hybrid#hook_add']() end
    }

    use 'itchyny/lightline.vim'
    use 'cocopon/lightline-hybrid.vim'

    use {
        'simeji/winresizer',
        config = function() vim.fn['plugin#winresizer#hook_source']() end
    }

    use {
        'neovimhaskell/haskell-vim',
        ft = {'haskell'}
    }

    use {
        'scrooloose/syntastic',
        ft = {'swift'}
    }
    use {
        'keith/swift.vim',
        ft = {'swift'}
    }
end)

