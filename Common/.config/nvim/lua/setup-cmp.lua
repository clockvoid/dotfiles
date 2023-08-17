vim.lsp.set_log_level('ERROR')
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.keymap.set('n', '<C-M-l>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        vim.keymap.set('n', 'L', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.keymap.set('n', '<C-M-b>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.keymap.set('n', '<F6>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        vim.keymap.set('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist<CR>', opts)
        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
        )
    end,
})

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
        { name = 'buffer' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
    }, {
        { name = 'cmdline' }
    })
})

require('mason').setup()
require('mason-lspconfig').setup_handlers {
    function(server_name)
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } }
                }
            }
        }
    end,
}
require('lspconfig').hls.setup {
    Filetypes = { 'haskell' },
    cmd = { 'haskell-language-server-wrapper', '--lsp' }
}
require('lspconfig').sourcekit.setup {
    Filetypes = { 'swift' },
    cmd = { 'sourcekit-lsp' }
}
require('lspconfig').dartls.setup {
    Filetyles = { 'dart' },
    cmd = { 'dart', 'language-server', '--client-id', 'neovim.lsp' }
}
